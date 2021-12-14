Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C664739B6
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 01:43:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCfkg6KHSz2yw1
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 11:43:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tVsQA7M7;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tVsQA7M7; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCfkZ0hdXz2yYx
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 11:43:33 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9EC17B8049B;
 Tue, 14 Dec 2021 00:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E15FC34600;
 Tue, 14 Dec 2021 00:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639442608;
 bh=ty1yRo6QpYXn3s4AkGa4PBQAMxtO3IeMQObPezZF3EA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tVsQA7M70qC7AEWp+7G6FYAbFzWR93/Q76L6Na5D25U1tQakZWOEF5xUt4Tr2lkvZ
 ZVBArduXEA3TVByRIV2BLGA0D3kae84WLZzpTIvcSuIW6vcugLodkplFUKxor1tn2O
 dixyMhqxllhNpmUcnQEAwWGyOGyvj47Q2v90zLKHkZvgdViVy38YkOH74srMezRJXT
 Hu6hmukdL3OmUptBJtrAfLaIZw83+zqD9klw16B02P5SmuS/MldYJokvp9P4SLoFo3
 EGVhFLWWtcFddK8JPycf8FerHl0wYyVh2RMkxeh6e49cOPGnnHr7AXvsddPX6vor/O
 VZWkH8sK+DH5Q==
Date: Tue, 14 Dec 2021 08:43:12 +0800
From: Gao Xiang <xiang@kernel.org>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v2 2/2] Add API to iterate over inodes in EROFS
Message-ID: <20211214004311.GA2891@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Kelvin Zhang <zhangkelvin@google.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>,
 Gao Xiang <xiang@kernel.org>
References: <20211209004659.4161847-1-zhangkelvin@google.com>
 <20211209012118.4175351-1-zhangkelvin@google.com>
 <20211209012118.4175351-3-zhangkelvin@google.com>
 <CAOSmRzif-ZjzdrMqQs_-hwRex5uPTLDTraB5d5tcjXf=WEjCbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOSmRzif-ZjzdrMqQs_-hwRex5uPTLDTraB5d5tcjXf=WEjCbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Kelvin,

On Mon, Dec 13, 2021 at 02:42:19PM -0800, Kelvin Zhang wrote:
> Friendly ping

Sorry for the delay. I didn't mean to ignore this patch.

Yet actually as I once said to Daeho, it would be better to introduce a
generic callback iterate function and convert fuse/dump/fsck in one patchset.

you could update some coding-style issues as erofs-utils follows Linux
kernel style.

> 
> On Wed, Dec 8, 2021 at 5:21 PM Kelvin Zhang <zhangkelvin@google.com> wrote:
> 
> > Change-Id: Ia35708080a72ee204eaaddfc670d3cb8023a078c
> > Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> > ---
> >  include/erofs/iterate.h |  57 +++++++++++++
> >  lib/Makefile.am         |   2 +-
> >  lib/iterate.c           | 173 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 231 insertions(+), 1 deletion(-)
> >  create mode 100644 include/erofs/iterate.h
> >  create mode 100644 lib/iterate.c
> >
> > diff --git a/include/erofs/iterate.h b/include/erofs/iterate.h
> > new file mode 100644
> > index 0000000..96171a7
> > --- /dev/null
> > +++ b/include/erofs/iterate.h
> > @@ -0,0 +1,57 @@
> > +//
> > +// Copyright (C) 2021 The Android Open Source Project
> > +//
> > +// Licensed under the Apache License, Version 2.0 (the "License");
> > +// you may not use this file except in compliance with the License.
> > +// You may obtain a copy of the License at
> > +//
> > +//      http://www.apache.org/licenses/LICENSE-2.0
> > +//
> > +// Unless required by applicable law or agreed to in writing, software
> > +// distributed under the License is distributed on an "AS IS" BASIS,
> > +// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
> > implied.
> > +// See the License for the specific language governing permissions and
> > +// limitations under the License.
> > +//

SPDX is enough, it'd be better to be licensed as GPL-2.0+ OR Apache-2.0,
see other files.

> > +
> > +#ifndef ITERATE_ITERATE
> > +#define ITERATE_ITERATE
> > +
> > +#ifdef __cplusplus
> > +extern "C"
> > +{
> > +#endif
> > +
> > +
> > +#include "erofs/io.h"
> > +#include "erofs/print.h"
> > +
> > +
> > +struct erofs_inode_info {
> > +  uint64_t inode_id;

erofs_nid_t nid;

> > +  const char* name;

one tab instead of 2 spaces.

> > +  bool is_reg_file;

ftype.

> > +  u64 compressed_size;
> > +  u64 uncompressed_size;

Could we get these directly from erofs_inode?
so getting rid of them is better.

> > +  struct erofs_inode* inode;
> > +  void* arg;
> > +};
> > +// Callback function for iterating over inodes of EROFS
> > +
> > +typedef bool (*ErofsIterCallback)(struct erofs_inode_info);

no camelcases, erofs_readdir_cb seems better.

and struct erofs_inode_info *.

> > +
> > +int erofs_iterate_dir(const struct erofs_sb_info* sbi,
> > +                   erofs_nid_t nid,
> > +                   erofs_nid_t parent_nid,
> > +                   ErofsIterCallback cb,
> > +                   void* arg);
> > +int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
> > +                        ErofsIterCallback cbg,
> > +                        void* arg);
> > +int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size);
> > +
> > +#ifdef __cplusplus
> > +}
> > +#endif
> > +
> > +#endif  // ITERATE_ITERATE
> > diff --git a/lib/Makefile.am b/lib/Makefile.am
> > index 67ba798..20c0e4f 100644
> > --- a/lib/Makefile.am
> > +++ b/lib/Makefile.am
> > @@ -27,7 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
> >  noinst_HEADERS += compressor.h
> >  liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c
> > exclude.c \
> >                       namei.c data.c compress.c compressor.c zmap.c
> > decompress.c \
> > -                     compress_hints.c hashmap.c sha256.c blobchunk.c
> > +                     compress_hints.c hashmap.c sha256.c blobchunk.c
> > iterate.c
> >  liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> >  if ENABLE_LZ4
> >  liberofs_la_CFLAGS += ${LZ4_CFLAGS}
> > diff --git a/lib/iterate.c b/lib/iterate.c
> > new file mode 100644
> > index 0000000..1a10ec1
> > --- /dev/null
> > +++ b/lib/iterate.c
> > @@ -0,0 +1,173 @@
> > +//
> > +// Copyright (C) 2021 The Android Open Source Project
> > +//
> > +// Licensed under the Apache License, Version 2.0 (the "License");
> > +// you may not use this file except in compliance with the License.
> > +// You may obtain a copy of the License at
> > +//
> > +//      http://www.apache.org/licenses/LICENSE-2.0
> > +//
> > +// Unless required by applicable law or agreed to in writing, software
> > +// distributed under the License is distributed on an "AS IS" BASIS,
> > +// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
> > implied.
> > +// See the License for the specific language governing permissions and
> > +// limitations under the License.
> > +//

Same here.

> > +
> > +#include "erofs/internal.h"
> > +#include "erofs_fs.h"
> > +#include "erofs/print.h"
> > +#include "erofs/iterate.h"
> > +
> > +static int erofs_read_dirent(const struct erofs_sb_info* sbi,
> > +                             const struct erofs_dirent* de,
> > +                             erofs_nid_t nid,
> > +                             erofs_nid_t parent_nid,
> > +                             const char* dname,
> > +                             ErofsIterCallback cb,
> > +                             void* arg) {
> > +  int err;
> > +  erofs_off_t occupied_size = 0;
> > +  struct erofs_inode inode = {.nid = de->nid};
> > +  err = erofs_read_inode_from_disk(&inode);
> > +  if (err) {
> > +    erofs_err("read file inode from disk failed!");
> > +    return err;
> > +  }
> > +  err = erofs_get_occupied_size(&inode, &occupied_size);
> > +  if (err) {
> > +    erofs_err("get file size failed\n");
> > +    return err;
> > +  }

no need to do this.

> > +  char buf[PATH_MAX + 1];
> > +  erofs_get_inode_name(sbi, de->nid, buf, PATH_MAX + 1);
> > +  struct erofs_inode_info info = {
> > +      .inode_id = de->nid,
> > +      .name = buf,
> > +      .is_reg_file = de->file_type == EROFS_FT_REG_FILE,
> > +      .compressed_size = occupied_size,
> > +      .uncompressed_size = inode.i_size,
> > +      .inode = &inode,
> > +      .arg = arg};
> > +  cb(info);
> > +  if ((de->file_type == EROFS_FT_DIR) && de->nid != nid &&
> > +      de->nid != parent_nid) {
> > +    err = erofs_iterate_dir(sbi, de->nid, nid, cb, arg);
> > +    if (err) {
> > +      erofs_err("parse dir nid %u error occurred\n",
> > +                (unsigned int)(de->nid));
> > +      return err;
> > +    }
> > +  }
> > +  return 0;
> > +}
> > +
> > +static inline int erofs_checkdirent(const struct erofs_dirent* de,
> > +                                    const struct erofs_dirent* last_de,
> > +                                    u32 maxsize,
> > +                                    const char* dname) {
> > +  int dname_len;
> > +  unsigned int nameoff = le16_to_cpu(de->nameoff);
> > +  if (nameoff < sizeof(struct erofs_dirent) || nameoff >= PAGE_SIZE) {
> > +    erofs_err("invalid de[0].nameoff %u @ nid %llu", nameoff, de->nid |
> > 0ULL);
> > +    return -EFSCORRUPTED;
> > +  }
> > +  dname_len = (de + 1 >= last_de) ? strnlen(dname, maxsize - nameoff)
> > +                                  : le16_to_cpu(de[1].nameoff) - nameoff;
> > +  /* a corrupted entry is found */
> > +  if (nameoff + dname_len > maxsize || dname_len > EROFS_NAME_LEN) {
> > +    erofs_err("bogus dirent @ nid %llu", le64_to_cpu(de->nid) | 0ULL);
> > +    DBG_BUGON(1);
> > +    return -EFSCORRUPTED;
> > +  }
> > +  if (de->file_type >= EROFS_FT_MAX) {
> > +    erofs_err("invalid file type %u", (unsigned int)(de->nid));
> > +    return -EFSCORRUPTED;
> > +  }
> > +  return dname_len;
> > +}
> > +
> > +int erofs_iterate_dir(const struct erofs_sb_info* sbi,
> > +                   erofs_nid_t nid,

nid is optional unless we do a fsck.

Thanks,
Gao Xiang
