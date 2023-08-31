Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D678EB07
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 12:49:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RbyZh5P6pz30hM
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 20:49:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.237; helo=smtp237.sjtu.edu.cn; envelope-from=lyy0627@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp237.sjtu.edu.cn (smtp237.sjtu.edu.cn [202.120.2.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RbyZZ1b61z307h
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 20:48:51 +1000 (AEST)
Received: from proxy189.sjtu.edu.cn (smtp189.sjtu.edu.cn [202.120.2.189])
	by smtp237.sjtu.edu.cn (Postfix) with ESMTPS id 93D277FA28;
	Thu, 31 Aug 2023 18:48:37 +0800 (CST)
Received: from [192.168.31.108] (unknown [139.227.253.35])
	by proxy189.sjtu.edu.cn (Postfix) with ESMTPSA id 24E893FC4EE;
	Thu, 31 Aug 2023 18:48:35 +0800 (CST)
Message-ID: <54abca78-bdc7-9520-4e95-75f32f451a5c@sjtu.edu.cn>
Date: Thu, 31 Aug 2023 18:48:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] erofs-utils: add support for fuse 2/3 lowlevel API
To: Huang Jianan <jnhuang95@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20230823115955.3679838-1-lyy0627@sjtu.edu.cn>
 <CAJfKizqAuRTndcq+jQAAn=H2rD1bqcg6Mek0x4KHxrAfPwe2MQ@mail.gmail.com>
From: Li Yiyan <lyy0627@sjtu.edu.cn>
In-Reply-To: <CAJfKizqAuRTndcq+jQAAn=H2rD1bqcg6Mek0x4KHxrAfPwe2MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,
Thanks for your thoughtful comments, here are my replies.

On 2023/8/26 17:25, Huang Jianan wrote:
> Hi Yiyan,
> Thanks for your work, I have some comments below, please check.
> 
> On 2023/8/23 19:59, Li Yiyan wrote:
>> Add support for the fuse low-level API in erofsfuse, proven correct in
>> 22 test cases. Lowlevel API offers improved performance compared to the
>> high-level API, while maintaining compatibility with fuse version
>> 2(>=2.6) and 3 (>=3.0).
>>
>> Dataset: linux 5.15
>> Compression algorithm: -z4hc,12
>> Additional options: -T0 -C16384
>> Test options: --warmup 3 -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1"
>>
>> Evaluation result (highlevel->lowlevel avg time):
>>       - Sequence metadata: 777.3 ms->180.9 ms
>>       - Sequence data: 3.282 s->818.1 ms
>>       - Random metadata: 1.571 s->928.3 ms
>>       - Random data: 2.461 s->597.8 ms
>>
>> Signed-off-by: Li Yiyan <lyy0627@sjtu.edu.cn>
>> ---
>> Changes since v6:
>> - remove redundant code
>> - optimize naming
>> - add eval data
>>
>> Changes since v5:
>> - name retval to `ret` from `err`
>>
>> Changes since v4:
>> - support fuse option
>> - default run in daemon
>> - remove redundant log
>>
>> Changes since v3:
>> - remove ll identifier
>> - optimize naming
>> - remove redundant log
>> - add fixme label for confusing xattr_buf
>>
>> Changes since v2:
>> - merge lowlevel.c into main.c
>> - fix typo in autoconf
>> - optimize naming
>> - remove redundant code
>> - avoid global sbi dependencies
>>
>> Changes since v1:
>> - remove highlevel fallback path
>> - remove redundant code
>> - add static for erofsfuse_ll_func
>> ---
>>   configure.ac     |  23 +-
>>   fuse/Makefile.am |   4 +-
>>   fuse/main.c      | 621 ++++++++++++++++++++++++++++++++++++++---------
>>   3 files changed, 523 insertions(+), 125 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index a8cecd0..6d08d96 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -336,15 +336,26 @@ AS_IF([test "x$with_selinux" != "xno"], [
>>
>>   # Configure fuse
>>   AS_IF([test "x$enable_fuse" != "xno"], [
>> -  PKG_CHECK_MODULES([libfuse], [fuse >= 2.6])
>>     # Paranoia: don't trust the result reported by pkgconfig before trying out
>>     saved_LIBS="$LIBS"
>>     saved_CPPFLAGS=${CPPFLAGS}
>> -  CPPFLAGS="${libfuse_CFLAGS} ${CPPFLAGS}"
>> -  LIBS="${libfuse_LIBS} $LIBS"
>> -  AC_CHECK_LIB(fuse, fuse_main, [
>> -    have_fuse="yes" ], [
>> -    AC_MSG_ERROR([libfuse (>= 2.6) doesn't work properly])])
>> +  PKG_CHECK_MODULES([libfuse3], [fuse3 >= 3.0], [
>> +    AC_DEFINE([FUSE_USE_VERSION], [30], [used FUSE API version])
>> +    CPPFLAGS="${libfuse3_CFLAGS} ${CPPFLAGS}"
>> +    LIBS="${libfuse3_LIBS} $LIBS"
>> +    AC_CHECK_LIB(fuse3, fuse_session_new, [], [
>> +    AC_MSG_ERROR([libfuse3 (>= 3.0) doesn't work properly for lowlevel api])])
>> +    have_fuse="yes"
>> +  ], [
>> +    PKG_CHECK_MODULES([libfuse2], [fuse >= 2.6], [
>> +      AC_DEFINE([FUSE_USE_VERSION], [26], [used FUSE API version])
>> +      CPPFLAGS="${libfuse2_CFLAGS} ${CPPFLAGS}"
>> +      LIBS="${libfuse2_LIBS} $LIBS"
>> +      AC_CHECK_LIB(fuse, fuse_lowlevel_new, [], [
>> +        AC_MSG_ERROR([libfuse (>= 2.6) doesn't work properly for lowlevel api])])
>> +      have_fuse="yes"
>> +    ], [have_fuse="no"])
>> +  ])
>>     LIBS="${saved_LIBS}"
>>     CPPFLAGS="${saved_CPPFLAGS}"], [have_fuse="no"])
>>
>> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
>> index 50be783..c63efcd 100644
>> --- a/fuse/Makefile.am
>> +++ b/fuse/Makefile.am
>> @@ -5,6 +5,6 @@ noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
>>   bin_PROGRAMS     = erofsfuse
>>   erofsfuse_SOURCES = main.c
>>   erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
>> -erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
>> -erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
>> +erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
>> +erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
>>       ${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
>> diff --git a/fuse/main.c b/fuse/main.c
>> index 821d98c..ecb4e81 100644
>> --- a/fuse/main.c
>> +++ b/fuse/main.c
>> @@ -1,13 +1,12 @@
>>   // SPDX-License-Identifier: GPL-2.0+
>>   /*
>>    * Created by Li Guifu <blucerlee@gmail.com>
>> + * Lowlevel added by Li Yiyan <lyy0627@sjtu.edu.cn>
>>    */
>>   #include <stdlib.h>
>>   #include <string.h>
>>   #include <signal.h>
>>   #include <libgen.h>
>> -#include <fuse.h>
>> -#include <fuse_opt.h>
>>   #include "macosx.h"
>>   #include "erofs/config.h"
>>   #include "erofs/print.h"
>> @@ -15,177 +14,507 @@
>>   #include "erofs/dir.h"
>>   #include "erofs/inode.h"
>>
>> -struct erofsfuse_dir_context {
>> +#include <float.h>
>> +#include <fuse.h>
>> +#include <fuse_lowlevel.h>
>> +
>> +/* used in list/getxattr, given buf size is 0 and
>> + * expected return val is xattr size
>> + * FIXME: remove this workaround by new lib interface
>> + */
>> +#define EROFSFUSE_XATTR_BUF_SIZE 4096
>> +#define EROFSFUSE_TIMEOUT DBL_MAX
>> +
>> +struct erofsfuse_readdir_context {
>>       struct erofs_dir_context ctx;
>> -     fuse_fill_dir_t filler;
>> -     struct fuse_file_info *fi;
>> +
>> +     fuse_req_t req;
>>       void *buf;
>> +     int is_plus;
>> +     size_t offset;
>> +     size_t buf_size;
>> +     size_t start_off;
>> +     struct fuse_file_info *fi;
>> +};
>> +
>> +struct erofsfuse_lookupdir_context {
>> +     struct erofs_dir_context ctx;
>> +
>> +     const char *target_name;
>> +     struct fuse_entry_param *ent;
>>   };
>>
>> -static int erofsfuse_fill_dentries(struct erofs_dir_context *ctx)
>> +static int erofsfuse_add_dentry(struct erofs_dir_context *ctx)
>>   {
>> -     struct erofsfuse_dir_context *fusectx = (void *)ctx;
>> -     struct stat st = {0};
>> +     size_t size = 0;
>>       char dname[EROFS_NAME_LEN + 1];
>> +     struct erofsfuse_readdir_context *readdir_ctx = (void *)ctx;
>> +
>> +     if (readdir_ctx->offset < readdir_ctx->start_off) {
>> +             readdir_ctx->offset +=
>> +                     ctx->de_namelen + sizeof(struct erofs_dirent);
>> +             return 0;
>> +     }
>>
>>       strncpy(dname, ctx->dname, ctx->de_namelen);
>>       dname[ctx->de_namelen] = '\0';
>> -     st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype) << 12;
>> -     fusectx->filler(fusectx->buf, dname, &st, 0);
>> +     readdir_ctx->offset += ctx->de_namelen + sizeof(struct erofs_dirent);
>> +
>> +     if (!readdir_ctx->is_plus) { /* fuse 3 still use non-plus readdir */
>> +             struct stat st = { 0 };
>> +
>> +             st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype);
>> +             st.st_ino = ctx->de_nid;
>> +             size = fuse_add_direntry(readdir_ctx->req, readdir_ctx->buf,
>> +                                      readdir_ctx->buf_size, dname, &st,
>> +                                      readdir_ctx->offset);
>> +     } else {
>> +#if FUSE_MAJOR_VERSION >= 3
>> +             struct fuse_entry_param param;
>> +
>> +             param.ino = ctx->de_nid;
>> +             param.generation = 0;
>> +             param.attr.st_ino = ctx->de_nid;
>> +             param.attr.st_mode = erofs_ftype_to_dtype(ctx->de_ftype);
>> +             param.attr_timeout = param.entry_timeout = EROFSFUSE_TIMEOUT;
>> +             size = fuse_add_direntry_plus(readdir_ctx->req,
>> +                                           readdir_ctx->buf,
>> +                                           readdir_ctx->buf_size, dname,
>> +                                           &param, readdir_ctx->offset);
>> +#else
>> +             erofs_err("fuse 2 readdirplus is not supported");
>> +#endif
>> +     }
>> +
>> +     if (size > readdir_ctx->buf_size) {
>> +             readdir_ctx->offset -=
>> +                     ctx->de_namelen + sizeof(struct erofs_dirent);
>> +             return 1;
>> +     }
>> +     readdir_ctx->buf += size;
>> +     readdir_ctx->buf_size -= size;
>>       return 0;
>>   }
>>
>> -int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
>> -                   off_t offset, struct fuse_file_info *fi)
>> +static void erofsfuse_fill_stat(struct erofs_inode *vi, struct stat *stbuf)
>>   {
>> -     int ret;
>> -     struct erofs_inode dir;
>> -     struct erofsfuse_dir_context ctx = {
>> -             .ctx.dir = &dir,
>> -             .ctx.cb = erofsfuse_fill_dentries,
>> -             .filler = filler,
>> -             .fi = fi,
>> -             .buf = buf,
>> -     };
>> -     erofs_dbg("readdir:%s offset=%llu", path, (long long)offset);
>> -
>> -     dir.sbi = &sbi;
>> -     ret = erofs_ilookup(path, &dir);
>> -     if (ret)
>> -             return ret;
>> +     stbuf->st_mode = vi->i_mode;
>> +     stbuf->st_nlink = vi->i_nlink;
>> +
>> +     if (!S_ISDIR(stbuf->st_mode))
>> +             stbuf->st_size = vi->i_size;
> 
> Why are directories skipped here? This causes the directory size read
> from erofsfuse to be 0.

Thanks. I'll fix it in V8.

> 
>> +     if (S_ISBLK(vi->i_mode) || S_ISCHR(vi->i_mode))
>> +             stbuf->st_rdev = vi->u.i_rdev;
>> +     stbuf->st_blocks = roundup(vi->i_size, erofs_blksiz(&sbi)) >> 9;
>> +     stbuf->st_uid = vi->i_uid;
>> +     stbuf->st_gid = vi->i_gid;
>> +     stbuf->st_ctime = vi->i_mtime;
>> +     stbuf->st_mtime = stbuf->st_ctime;
>> +     stbuf->st_atime = stbuf->st_ctime;
>> +}
>>
>> -     erofs_dbg("path=%s nid = %llu", path, dir.nid | 0ULL);
>> -     if (!S_ISDIR(dir.i_mode))
>> -             return -ENOTDIR;
>> +static int erofsfuse_lookup_dentry(struct erofs_dir_context *ctx)
>> +{
>> +     struct erofsfuse_lookupdir_context *lookup_ctx = (void *)ctx;
>>
>> -     if (!dir.i_size)
>> +     if (lookup_ctx->ent->ino != 0 ||
>> +         strlen(lookup_ctx->target_name) != ctx->de_namelen)
>>               return 0;
>> +
>> +     if (!strncmp(lookup_ctx->target_name, ctx->dname, ctx->de_namelen)) {
>> +             int ret;
>> +             struct erofs_inode vi = {
>> +                     .sbi = &sbi,
>> +                     .nid = (erofs_nid_t)ctx->de_nid,
>> +             };
>> +
>> +             ret = erofs_read_inode_from_disk(&vi);
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             lookup_ctx->ent->ino = ctx->de_nid;
>> +             lookup_ctx->ent->attr.st_ino = ctx->de_nid;
>> +
>> +             erofsfuse_fill_stat(&vi, &(lookup_ctx->ent->attr));
>> +     }
>> +     return 0;
>> +}
>> +
>> +static inline erofs_nid_t erofsfuse_getnid(fuse_ino_t ino)
>> +{
>> +     return ino == FUSE_ROOT_ID ? sbi.root_nid : (erofs_nid_t)ino;
>> +}
>> +
>> +static inline void erofsfuse_readdir_general(fuse_req_t req, fuse_ino_t ino,
>> +                                          size_t size, off_t off,
>> +                                          struct fuse_file_info *fi,
>> +                                          int plus)
>> +{
>> +     int ret = 0;
>> +     char *buf = malloc(size);
>> +     struct erofsfuse_readdir_context ctx;
>> +     struct erofs_inode *vi = (struct erofs_inode *)fi->fh;
>> +
>> +     erofs_dbg("ino: %lu, size: %lu, off: %lu, plus: %d", ino, size, off,
>> +               plus);
>> +
>> +     if (!buf) {
>> +             fuse_reply_err(req, ENOMEM);
>> +             return;
>> +     }
>> +     ctx.ctx.dir = vi;
>> +     ctx.ctx.cb = erofsfuse_add_dentry;
>> +
>> +     ctx.fi = fi;
>> +     ctx.buf = buf;
>> +     ctx.buf_size = size;
>> +     ctx.req = req;
>> +     ctx.offset = 0;
>> +     ctx.start_off = off;
>> +     ctx.is_plus = plus;
>> +
>>   #ifdef NDEBUG
>> -     return erofs_iterate_dir(&ctx.ctx, false);
>> +     ret = erofs_iterate_dir(&ctx.ctx, false);
>>   #else
>> -     return erofs_iterate_dir(&ctx.ctx, true);
>> +     ret = erofs_iterate_dir(&ctx.ctx, true);
>>   #endif
>> +
>> +     if (ret < 0) /* if buffer insufficient, return 1 */
>> +             fuse_reply_err(req, EIO);
>> +     else
>> +             fuse_reply_buf(req, buf, size - ctx.buf_size);
>> +
>> +     free(buf);
>> +}
>> +
>> +static void erofsfuse_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
>> +                           off_t off, struct fuse_file_info *fi)
>> +{
>> +     erofsfuse_readdir_general(req, ino, size, off, fi, 0);
>> +}
>> +
>> +#if FUSE_MAJOR_VERSION >= 3
>> +static void erofsfuse_readdirplus(fuse_req_t req, fuse_ino_t ino, size_t size,
>> +                               off_t off, struct fuse_file_info *fi)
>> +{
>> +     erofsfuse_readdir_general(req, ino, size, off, fi, 1);
>>   }
>> +#endif
>>
>> -static void *erofsfuse_init(struct fuse_conn_info *info)
>> +static void erofsfuse_init(void *userdata, struct fuse_conn_info *conn)
>>   {
>> -     erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
>> -     return NULL;
>> +     erofs_info("Using FUSE protocol %d.%d", conn->proto_major,
>> +                conn->proto_minor);
>>   }
>>
>> -static int erofsfuse_open(const char *path, struct fuse_file_info *fi)
>> +static void erofsfuse_open(fuse_req_t req, fuse_ino_t ino,
>> +                        struct fuse_file_info *fi)
>>   {
>> -     erofs_dbg("open path=%s", path);
>> +     int ret = 0;
>> +     struct erofs_inode *vi;
>>
>> -     if ((fi->flags & O_ACCMODE) != O_RDONLY)
>> -             return -EACCES;
>> +     if (fi->flags & (O_WRONLY | O_RDWR)) {
>> +             fuse_reply_err(req, EROFS);
>> +             return;
>> +     }
>>
>> -     return 0;
>> +     if (ino == FUSE_ROOT_ID) {
>> +             fuse_reply_err(req, EISDIR);
> 
> How about removing the check here? FUSE has already ensured this in kernel.

Thanks.

> 
>> +             return;
>> +     }
>> +
>> +     vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
>> +     if (!vi) {
>> +             fuse_reply_err(req, ENOMEM);
>> +             return;
>> +     }
>> +
>> +     vi->sbi = &sbi;
>> +     vi->nid = (erofs_nid_t)ino;
>> +     ret = erofs_read_inode_from_disk(vi);
>> +     if (ret < 0) {
>> +             fuse_reply_err(req, EIO);
> 
> Maybe reply -ret? Since there are other errors in
> erofs_read_inode_from_disk.

No. As mentioned in declaration, param err represents the *positive* error value,
or zero for success.
> 
>> +             goto out;
>> +     }
>> +
>> +     if (!S_ISREG(vi->i_mode)) {
>> +             fuse_reply_err(req, EISDIR);
> 
> Ditto.
> 
>> +     } else {
>> +             fi->fh = (uint64_t)vi;
>> +             fi->keep_cache = 1;
>> +             fuse_reply_open(req, fi);
>> +             return;
>> +     }
>> +
>> +out:
>> +     free(vi);
>>   }
>>
>> -static int erofsfuse_getattr(const char *path, struct stat *stbuf)
>> +static void erofsfuse_getattr(fuse_req_t req, fuse_ino_t ino,
>> +                           struct fuse_file_info *fi)
>>   {
>> -     struct erofs_inode vi = { .sbi = &sbi };
>>       int ret;
>> +     struct stat stbuf = { 0 };
>> +     struct erofs_inode vi = { .sbi = &sbi, .nid = erofsfuse_getnid(ino) };
>>
>> -     erofs_dbg("getattr(%s)", path);
>> -     ret = erofs_ilookup(path, &vi);
>> -     if (ret)
>> -             return -ENOENT;
>> -
>> -     stbuf->st_mode  = vi.i_mode;
>> -     stbuf->st_nlink = vi.i_nlink;
>> -     stbuf->st_size  = vi.i_size;
>> -     stbuf->st_blocks = roundup(vi.i_size, erofs_blksiz(vi.sbi)) >> 9;
>> -     stbuf->st_uid = vi.i_uid;
>> -     stbuf->st_gid = vi.i_gid;
>> -     if (S_ISBLK(vi.i_mode) || S_ISCHR(vi.i_mode))
>> -             stbuf->st_rdev = vi.u.i_rdev;
>> -     stbuf->st_ctime = vi.i_mtime;
>> -     stbuf->st_mtime = stbuf->st_ctime;
>> -     stbuf->st_atime = stbuf->st_ctime;
>> -     return 0;
>> +     ret = erofs_read_inode_from_disk(&vi);
>> +     if (ret < 0)
>> +             fuse_reply_err(req, ENOENT);
> 
> Ditto.
> 
>> +
>> +     erofsfuse_fill_stat(&vi, &stbuf);
>> +     stbuf.st_ino = ino;
>> +
>> +     fuse_reply_attr(req, &stbuf, EROFSFUSE_TIMEOUT);
>>   }
>>
>> -static int erofsfuse_read(const char *path, char *buffer,
>> -                       size_t size, off_t offset,
>> -                       struct fuse_file_info *fi)
>> +static void erofsfuse_opendir(fuse_req_t req, fuse_ino_t ino,
>> +                           struct fuse_file_info *fi)
>>   {
>>       int ret;
>> -     struct erofs_inode vi;
>> +     struct erofs_inode *vi;
>>
>> -     erofs_dbg("path:%s size=%zd offset=%llu", path, size, (long long)offset);
>> +     vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
>> +     if (!vi) {
>> +             fuse_reply_err(req, ENOMEM);
>> +             return;
>> +     }
>>
>> -     vi.sbi = &sbi;
>> -     ret = erofs_ilookup(path, &vi);
>> -     if (ret)
>> -             return ret;
>> +     vi->sbi = &sbi;
>> +     vi->nid = erofsfuse_getnid(ino);
>> +     ret = erofs_read_inode_from_disk(vi);
>> +     if (ret < 0) {
>> +             fuse_reply_err(req, EIO);
> 
> Ditto.
> 
>> +             goto out;
>> +     }
>>
>> -     ret = erofs_pread(&vi, buffer, size, offset);
>> -     if (ret)
>> -             return ret;
>> -     if (offset >= vi.i_size)
>> -             return 0;
>> -     if (offset + size > vi.i_size)
>> -             return vi.i_size - offset;
>> -     return size;
>> +     if (!S_ISDIR(vi->i_mode)) {
>> +             fuse_reply_err(req, ENOTDIR);
> 
> Ditto.
> 
>> +             goto out;
>> +     }
>> +
>> +     fi->fh = (uint64_t)vi;
>> +     fuse_reply_open(req, fi);
>> +     return;
>> +
>> +out:
>> +     free(vi);
>>   }
>>
>> -static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
>> +static void erofsfuse_release(fuse_req_t req, fuse_ino_t ino,
>> +                           struct fuse_file_info *fi)
>>   {
>> -     int ret = erofsfuse_read(path, buffer, size, 0, NULL);
>> -
>> -     if (ret < 0)
>> -             return ret;
>> -     DBG_BUGON(ret > size);
>> -     if (ret == size)
>> -             buffer[size - 1] = '\0';
>> -     erofs_dbg("readlink(%s): %s", path, buffer);
>> -     return 0;
>> +     free((struct erofs_inode *)fi->fh);
>> +     fi->fh = 0;
>> +     fuse_reply_err(req, 0);
>>   }
>>
>> -static int erofsfuse_getxattr(const char *path, const char *name, char *value,
>> -                     size_t size
>> -#ifdef __APPLE__
>> -                     , uint32_t position)
>> +static void erofsfuse_lookup(fuse_req_t req, fuse_ino_t parent,
>> +                          const char *name)
>> +{
>> +     int ret;
>> +     struct erofs_inode *vi;
>> +     struct fuse_entry_param fentry;
>> +     struct erofsfuse_lookupdir_context ctx;
>> +
>> +     vi = (struct erofs_inode *)malloc(sizeof(struct erofs_inode));
>> +     if (!vi) {
>> +             fuse_reply_err(req, ENOMEM);
>> +             return;
>> +     }
>> +
>> +     vi->sbi = &sbi;
>> +     vi->nid = erofsfuse_getnid(parent);
>> +     ret = erofs_read_inode_from_disk(vi);
>> +     if (ret < 0) {
>> +             fuse_reply_err(req, EIO);
> 
> Ditto.
> 
>> +             goto out;
>> +     }
>> +     if (!S_ISDIR(vi->i_mode)) {
>> +             fuse_reply_err(req, ENOTDIR);
> 
> Ditto.
> 
>> +             goto out;
>> +     }
>> +
>> +     memset(&fentry, 0, sizeof(fentry));
>> +     fentry.ino = 0;
>> +     fentry.attr_timeout = fentry.entry_timeout = EROFSFUSE_TIMEOUT;
>> +     ctx.ctx.dir = vi;
>> +     ctx.ctx.cb = erofsfuse_lookup_dentry;
>> +
>> +     ctx.ent = &fentry;
>> +     ctx.target_name = name;
>> +
>> +#ifdef NDEBUG
>> +     ret = erofs_iterate_dir(&ctx.ctx, false);
>>   #else
>> -                     )
>> +     ret = erofs_iterate_dir(&ctx.ctx, true);
>>   #endif
>> +
>> +     if (ret < 0) {
>> +             fuse_reply_err(req, EIO);
> 
> Ditto.
> 
>> +             goto out;
>> +     }
>> +     fuse_reply_entry(req, &fentry);
>> +
>> +out:
>> +     free(vi);
>> +}
>> +
>> +static void erofsfuse_read(fuse_req_t req, fuse_ino_t ino, size_t size,
>> +                        off_t off, struct fuse_file_info *fi)
>>   {
>>       int ret;
>> -     struct erofs_inode vi;
>> +     struct erofs_inode *vi = (struct erofs_inode *)fi->fh;
>> +     char *buf;
>>
>> -     erofs_dbg("getxattr(%s): name=%s size=%llu", path, name, size);
>> +     erofs_dbg("ino = %lu, size = %lu, off = %lu", ino, size, off);
>>
>> -     vi.sbi = &sbi;
>> -     ret = erofs_ilookup(path, &vi);
>> -     if (ret)
>> -             return ret;
>> +     if (!S_ISREG(vi->i_mode)) {
>> +             fuse_reply_err(req, EIO);
> 
> Ditto.
> 
>> +             return;
>> +     }
>> +
>> +     buf = malloc(size);
>> +     if (!buf) {
>> +             fuse_reply_err(req, ENOMEM);
>> +             return;
>> +     }
>> +
>> +     ret = erofs_pread(vi, buf, size, off);
>> +     if (ret) {
>> +             fuse_reply_err(req, EIO);
> 
> Ditto.
> 
>> +             goto out;
>> +     }
>> +     if (off >= vi->i_size)
>> +             ret = 0;
>> +     else if (off + size > vi->i_size)
>> +             ret = vi->i_size - off;
>> +     else
>> +             ret = size;
>> +
>> +     fuse_reply_buf(req, buf, ret);
>>
>> -     return erofs_getxattr(&vi, name, value, size);
>> +out:
>> +     free(buf);
>>   }
>>
>> -static int erofsfuse_listxattr(const char *path, char *list, size_t size)
>> +static void erofsfuse_readlink(fuse_req_t req, fuse_ino_t ino)
>>   {
>>       int ret;
>> -     struct erofs_inode vi;
>> +     char *dst;
>> +     struct erofs_inode vi = { .sbi = &sbi, .nid = erofsfuse_getnid(ino) };
>>
>> -     erofs_dbg("listxattr(%s): size=%llu", path, size);
>> +     ret = erofs_read_inode_from_disk(&vi);
>> +     if (ret < 0) {
>> +             fuse_reply_err(req, EIO);
> 
> Ditto.
> 
>> +             return;
>> +     }
>>
>> -     vi.sbi = &sbi;
>> -     ret = erofs_ilookup(path, &vi);
>> -     if (ret)
>> -             return ret;
>> +     if (!S_ISLNK(vi.i_mode)) {
>> +             fuse_reply_err(req, EINVAL);
> 
> Ditto.
> 
>> +             return;
>> +     }
>> +
>> +     dst = malloc(vi.i_size + 1);
>> +     if (!dst) {
>> +             fuse_reply_err(req, ENOMEM);
>> +             return;
>> +     }
>> +
>> +     ret = erofs_pread(&vi, dst, vi.i_size, 0);
>> +     if (ret < 0) {
>> +             fuse_reply_err(req, EIO);
> 
> Ditto.
> 
>> +             goto out;
>> +     }
>> +
>> +     dst[vi.i_size] = '\0';
>> +     fuse_reply_readlink(req, dst);
>> +
>> +out:
>> +     free(dst);
>> +}
>> +
>> +static void erofsfuse_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
>> +                            size_t size)
>> +{
>> +     int ret;
>> +     char *buf;
>> +     size_t bufsize = size;
>> +     struct erofs_inode vi = { .sbi = &sbi, .nid = erofsfuse_getnid(ino) };
>>
>> -     return erofs_listxattr(&vi, list, size);
>> +     erofs_dbg("ino = %lu, name = %s, size = %lu", ino, name, size);
>> +
>> +     ret = erofs_read_inode_from_disk(&vi);
>> +     if (ret < 0) {
>> +             fuse_reply_err(req, EIO);
> 
> Ditto.
> 
>> +             return;
>> +     }
>> +
>> +     if (bufsize == 0)
>> +             bufsize = EROFSFUSE_XATTR_BUF_SIZE;
> 
> Why do we need to reconfigure bufsize here? erofs_listxattr should
> handle bufsize of 0.


This is a workaround for the time being, I will propose a patch to modify the lib
to solve this problem.

As mentioned in https://man7.org/linux/man-pages/man2/listxattr.2.html:

"If size is specified as zero, these calls return the current size of the list of
extended attribute names ( and leave list unchanged). This can be used to determine
the size of the buffer that should be supplied in a subsequent call."

Therefore, buf=0 means that we need to use fuse_reply_xattr to return the requested
size of the buffer. Only when buf is not 0 do we need to copy xattr to buffer.
At present, the erofs_getxattr cannot solve this problem, so a workaround is
made on the fuse layer to temporarily solve this problem and
control the extent of the patch.

> 
>> +     buf = malloc(bufsize);
>> +     if (!buf) {
>> +             fuse_reply_err(req, ENOMEM);
>> +             return;
>> +     }
>> +
>> +     ret = erofs_getxattr(&vi, name, buf, bufsize);
>> +     if (ret < 0)
>> +             fuse_reply_err(req, -ret);
>> +     else if (size == 0)
>> +             fuse_reply_xattr(req, ret);
>> +     else
>> +             fuse_reply_buf(req, buf, ret);
>> +
>> +     free(buf);
>> +}
>> +
>> +static void erofsfuse_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
>> +{
>> +     int ret;
>> +     char *buf = NULL;
>> +     size_t bufsize = size;
>> +     struct erofs_inode vi = { .sbi = &sbi, .nid = erofsfuse_getnid(ino) };
>> +
>> +     erofs_dbg("ino = %lu, size = %lu", ino, size);
>> +
>> +     ret = erofs_read_inode_from_disk(&vi);
>> +     if (ret < 0) {
>> +             fuse_reply_err(req, EIO);
> 
> Ditto.
> 
>> +             return;
>> +     }
>> +
>> +     if (bufsize == 0)
>> +             bufsize = EROFSFUSE_XATTR_BUF_SIZE;
> 
> Ditto.
> 
>> +     buf = malloc(bufsize);
>> +     if (!buf) {
>> +             fuse_reply_err(req, ENOMEM);
>> +             return;
>> +     }
>> +
>> +     ret = erofs_listxattr(&vi, buf, bufsize);
>> +     if (ret < 0)
>> +             fuse_reply_err(req, -ret);
>> +     else if (size == 0)
>> +             fuse_reply_xattr(req, ret);
>> +     else
>> +             fuse_reply_buf(req, buf, ret);
>> +
>> +     free(buf);
>>   }
>>
>> -static struct fuse_operations erofs_ops = {
>> +static struct fuse_lowlevel_ops erofsfuse_lops = {
>>       .getxattr = erofsfuse_getxattr,
>> +     .opendir = erofsfuse_opendir,
>> +     .releasedir = erofsfuse_release,
>> +     .release = erofsfuse_release,
>> +     .lookup = erofsfuse_lookup,
>>       .listxattr = erofsfuse_listxattr,
>>       .readlink = erofsfuse_readlink,
>>       .getattr = erofsfuse_getattr,
>>       .readdir = erofsfuse_readdir,
>> +#if FUSE_MAJOR_VERSION >= 3
>> +     .readdirplus = erofsfuse_readdirplus,
>> +#endif
>>       .open = erofsfuse_open,
>>       .read = erofsfuse_read,
>>       .init = erofsfuse_init,
>> @@ -197,6 +526,7 @@ static struct options {
>>       u64 offset;
>>       unsigned int debug_lvl;
>>       bool show_help;
>> +     bool show_version;
>>       bool odebug;
>>   } fusecfg;
>>
>> @@ -205,13 +535,14 @@ static const struct fuse_opt option_spec[] = {
>>       OPTION("--offset=%lu", offset),
>>       OPTION("--dbglevel=%u", debug_lvl),
>>       OPTION("--help", show_help),
>> +     OPTION("--version", show_version),
>>       FUSE_OPT_KEY("--device=", 1),
>>       FUSE_OPT_END
>>   };
>>
>>   static void usage(void)
>>   {
>> -     struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
>> +     fprintf(stderr, "erofsfuse version: %s\n\n", cfg.c_version);
> 
> Maybe print the version of api? I'm not sure if this is necessary, just
> saw from the example below:
> https://github.com/libfuse/libfuse/blob/master/example/hello_ll.c#L233

Thanks. I'll add the version of kernel FUSE and fuse lib like this:

using FUSE kernel interface version 7.31
fusermount3 version: 3.10.5
erofsfuse version: 1.6-gc08168ef-dirty

> 
>>
>>       fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
>>             "Options:\n"
>> @@ -220,12 +551,15 @@ static void usage(void)
>>             "    --device=#             specify an extra device to be used together\n"
>>   #if FUSE_MAJOR_VERSION < 3
>>             "    --help                 display this help and exit\n"
>> +           "    --version              display erofsfuse version\n"
>>   #endif
>>             "\n", stderr);
>>
>>   #if FUSE_MAJOR_VERSION >= 3
>> +     fputs("\nFUSE options:\n", stderr);
>>       fuse_cmdline_help();
>>   #else
>> +     struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
>>       fuse_opt_add_arg(&args, ""); /* progname */
>>       fuse_opt_add_arg(&args, "-ho"); /* progname */
>>       fuse_parse_cmdline(&args, NULL, NULL, NULL);
>> @@ -266,12 +600,10 @@ static int optional_opt_func(void *data, const char *arg, int key,
>>       case FUSE_OPT_KEY_OPT:
>>               if (!strcmp(arg, "-d"))
>>                       fusecfg.odebug = true;
>> -             break;
>> -     default:
>> -             DBG_BUGON(1);
>> -             break;
>> +             if (!strncmp(arg, "-h", 2) || !strncmp(arg, "-v", 2))
>> +                     return -1;
> 
> how about:
> 
> if (!strncmp(arg, "-h", 2))
>         fusecfg.show_help = true;
> if (!strncmp(arg, "-V", 2))
>         fusecfg.show_version = true;
> 

Thanks.

>>       }
>> -     return 1;
>> +     return 1; // keep arg
>>   }
>>
>>   #if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
>> @@ -301,10 +633,20 @@ static void signal_handle_sigsegv(int signal)
>>   int main(int argc, char *argv[])
>>   {
>>       int ret;
>> +     struct fuse_session *se;
>>       struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
>> +#if FUSE_MAJOR_VERSION >= 3
>> +     struct fuse_cmdline_opts opts;
>> +#else
>> +     struct fuse_chan *ch;
>> +     struct {
>> +             char *mountpoint;
>> +             int mt, foreground;
>> +     } opts;
>> +#endif
>>
>>       erofs_init_configure();
>> -     printf("%s %s\n", basename(argv[0]), cfg.c_version);
>> +     erofs_dbg("%s %s", basename(argv[0]), cfg.c_version);
>>
>>   #if defined(HAVE_EXECINFO_H) && defined(HAVE_BACKTRACE)
>>       if (signal(SIGSEGV, signal_handle_sigsegv) == SIG_ERR) {
>> @@ -319,7 +661,16 @@ int main(int argc, char *argv[])
>>       if (ret)
>>               goto err;
>>
>> -     if (fusecfg.show_help || !fusecfg.mountpoint)
>> +#if FUSE_MAJOR_VERSION >= 3
>> +     ret = fuse_parse_cmdline(&args, &opts);
>> +#else
>> +     ret = (fuse_parse_cmdline(&args, &opts.mountpoint, &opts.mt,
>> +                               &opts.foreground) == -1);
>> +#endif
>> +     if (ret)
>> +             goto err;
>> +
>> +     if (fusecfg.show_help || fusecfg.show_version || !fusecfg.mountpoint)
>>               usage();
>>       cfg.c_dbg_lvl = fusecfg.debug_lvl;
>>
>> @@ -341,8 +692,44 @@ int main(int argc, char *argv[])
>>               goto err_dev_close;
>>       }
>>
>> -     ret = fuse_main(args.argc, args.argv, &erofs_ops, NULL);
>> +#if FUSE_MAJOR_VERSION >= 3
>> +     se = fuse_session_new(&args, &erofsfuse_lops, sizeof(erofsfuse_lops),
>> +                           NULL);
>> +     if (!se)
>> +             goto err_super_put;
>> +
>> +     if (fuse_session_mount(se, fusecfg.mountpoint) != -1) {
>> +             if (fuse_daemonize(opts.foreground) != -1) {
>> +                     if (fuse_set_signal_handlers(se) != -1) {
>> +                             ret = fuse_session_loop(se);
>> +                             fuse_remove_signal_handlers(se);
>> +                     }
>> +                     fuse_session_unmount(se);
>> +                     fuse_session_destroy(se);
>> +             }
>> +     }
>> +#else
>> +     ch = fuse_mount(fusecfg.mountpoint, &args);
>> +     if (!ch)
>> +             goto err_super_put;
>> +
>> +     se = fuse_lowlevel_new(&args, &erofsfuse_lops, sizeof(erofsfuse_lops),
>> +                            NULL);
>> +     if (se) {
>> +             if (fuse_daemonize(opts.foreground) != -1) {
>> +                     if (fuse_set_signal_handlers(se) != -1) {
>> +                             fuse_session_add_chan(se, ch);
>> +                             ret = fuse_session_loop(se);
>> +                             fuse_remove_signal_handlers(se);
>> +                             fuse_session_remove_chan(ch);
>> +                     }
>> +             }
>> +             fuse_session_destroy(se);
>> +     }
>> +     fuse_unmount(fusecfg.mountpoint, ch);
>> +#endif
>>
>> +err_super_put:
>>       erofs_put_super(&sbi);
>>   err_dev_close:
>>       blob_closeall(&sbi);
> 
> Thanks,
> Jianan

Thanks,
Yiyan
