Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4341678C729
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 16:17:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZqJK1NcXz3bN9
	for <lists+linux-erofs@lfdr.de>; Wed, 30 Aug 2023 00:17:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZqJF2CBFz2xr6
	for <linux-erofs@lists.ozlabs.org>; Wed, 30 Aug 2023 00:17:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vqrm1dj_1693318646;
Received: from 192.168.3.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vqrm1dj_1693318646)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 22:17:27 +0800
Message-ID: <fa8e14c6-a1cb-8737-941a-3b42d5cd4e99@linux.alibaba.com>
Date: Tue, 29 Aug 2023 22:17:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7] erofs-utils: add support for fuse 2/3 lowlevel API
To: Huang Jianan <jnhuang95@gmail.com>, Li Yiyan <lyy0627@sjtu.edu.cn>,
 linux-erofs@lists.ozlabs.org
References: <20230823115955.3679838-1-lyy0627@sjtu.edu.cn>
 <CAJfKizqAuRTndcq+jQAAn=H2rD1bqcg6Mek0x4KHxrAfPwe2MQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJfKizqAuRTndcq+jQAAn=H2rD1bqcg6Mek0x4KHxrAfPwe2MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Yiyan,

Would you mind addressing the following comments? I think it's almost
the time to formalize this:

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
>>        - Sequence metadata: 777.3 ms->180.9 ms
>>        - Sequence data: 3.282 s->818.1 ms
>>        - Random metadata: 1.571 s->928.3 ms
>>        - Random data: 2.461 s->597.8 ms
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
>>    configure.ac     |  23 +-
>>    fuse/Makefile.am |   4 +-
>>    fuse/main.c      | 621 ++++++++++++++++++++++++++++++++++++++---------
>>    3 files changed, 523 insertions(+), 125 deletions(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index a8cecd0..6d08d96 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -336,15 +336,26 @@ AS_IF([test "x$with_selinux" != "xno"], [
>>
>>    # Configure fuse
>>    AS_IF([test "x$enable_fuse" != "xno"], [
>> -  PKG_CHECK_MODULES([libfuse], [fuse >= 2.6])
>>      # Paranoia: don't trust the result reported by pkgconfig before trying out
>>      saved_LIBS="$LIBS"
>>      saved_CPPFLAGS=${CPPFLAGS}
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
>>      LIBS="${saved_LIBS}"
>>      CPPFLAGS="${saved_CPPFLAGS}"], [have_fuse="no"])
>>
>> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
>> index 50be783..c63efcd 100644
>> --- a/fuse/Makefile.am
>> +++ b/fuse/Makefile.am
>> @@ -5,6 +5,6 @@ noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
>>    bin_PROGRAMS     = erofsfuse
>>    erofsfuse_SOURCES = main.c
>>    erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
>> -erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
>> -erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
>> +erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
>> +erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
>>        ${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
>> diff --git a/fuse/main.c b/fuse/main.c
>> index 821d98c..ecb4e81 100644
>> --- a/fuse/main.c
>> +++ b/fuse/main.c
>> @@ -1,13 +1,12 @@
>>    // SPDX-License-Identifier: GPL-2.0+
>>    /*
>>     * Created by Li Guifu <blucerlee@gmail.com>
>> + * Lowlevel added by Li Yiyan <lyy0627@sjtu.edu.cn>
>>     */
>>    #include <stdlib.h>
>>    #include <string.h>
>>    #include <signal.h>
>>    #include <libgen.h>
>> -#include <fuse.h>
>> -#include <fuse_opt.h>
>>    #include "macosx.h"
>>    #include "erofs/config.h"
>>    #include "erofs/print.h"
>> @@ -15,177 +14,507 @@
>>    #include "erofs/dir.h"
>>    #include "erofs/inode.h"
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
>>        struct erofs_dir_context ctx;
>> -     fuse_fill_dir_t filler;
>> -     struct fuse_file_info *fi;
>> +
>> +     fuse_req_t req;
>>        void *buf;
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
>>    };
>>
>> -static int erofsfuse_fill_dentries(struct erofs_dir_context *ctx)
>> +static int erofsfuse_add_dentry(struct erofs_dir_context *ctx)
>>    {
>> -     struct erofsfuse_dir_context *fusectx = (void *)ctx;
>> -     struct stat st = {0};
>> +     size_t size = 0;
>>        char dname[EROFS_NAME_LEN + 1];
>> +     struct erofsfuse_readdir_context *readdir_ctx = (void *)ctx;
>> +
>> +     if (readdir_ctx->offset < readdir_ctx->start_off) {
>> +             readdir_ctx->offset +=
>> +                     ctx->de_namelen + sizeof(struct erofs_dirent);
>> +             return 0;
>> +     }
>>
>>        strncpy(dname, ctx->dname, ctx->de_namelen);
>>        dname[ctx->de_namelen] = '\0';
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

Does this really happen?  If so, should we fallback instead?

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
>>        return 0;
>>    }
>>
>> -int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
>> -                   off_t offset, struct fuse_file_info *fi)
>> +static void erofsfuse_fill_stat(struct erofs_inode *vi, struct stat *stbuf)

Please rename it as erofsfuse_getattr().

>>    {
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
>>                return 0;
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

I think you should use

static inline erofs_nid_t erofsfuse_to_nid(fuse_ino_t ino)

	if (ino == FUSE_ROOT_ID)
		return sbi.root_nid;
	return (erofs_nid_t)(ino - FUSE_ROOT_ID);

static inline erofs_nid_t erofsfuse_to_ino(erofs_nid_t nid)

	if (nid == sbi.root_nid)
		return FUSE_ROOT_NID;
	return (nid + FUSE_ROOT_ID);

instead.

>> +}
>> +

...

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

Yes, I don't know what happens too.

Thanks,
Gao Xiang
