FROM centos:7.6.1810
# First setup ruby
ENV SOLARGRAPH /solargraph
RUN mkdir -p $SOLARGRAPH
COPY . $SOLARGRAPH
WORKDIR $SOLARGRAPH
RUN yum groupinstall "Development Tools" -y
RUN yum install -y \
	openssl-devel \
	readline-devel \
	zlib-devel
ENV RUBY_VERSION 2.4.4
ENV RUBY_BUILD_GIT_URL https://github.com/rbenv/ruby-build.git
ENV RUBY_BASE_PATH /rubies/$RUBY_VERSION
ENV RUBY_BUILD_BASE_PATH /ruby-build
RUN mkdir -p $RUBY_BASE_PATH
RUN mkdir -p $RUBY_BUILD_BASE_PATH
RUN git clone $RUBY_BUILD_GIT_URL $RUBY_BUILD_BASE_PATH
RUN $RUBY_BUILD_BASE_PATH/bin/ruby-build $RUBY_VERSION $RUBY_BASE_PATH
ENV PATH "$RUBY_BASE_PATH/bin:${PATH}"
#RUN echo "$RUBY_BASE_PATH/bin:${PATH}" >> ~/.bash_profile
#RUN source ~/.bash_profile
RUN $RUBY_BASE_PATH/bin/gem install bundle
RUN $RUBY_BASE_PATH/bin/bundle install
RUN $RUBY_BASE_PATH/bin/gem install solargraph
ENTRYPOINT ["./bin/solargraph"]
CMD ["socket"]
#ENTRYPOINT ["$RUBY_BASE_PATH/bin/solargraph"]
#CMD ["socket"]
