Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F67473B8E
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 04:33:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCkVd4qb9z304j
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 14:33:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639452809;
	bh=z89n0bG58WVvUVaWPsozFrWBU2DPTAVTfWJ6jN8VJ2w=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=bNAYXR2eI6oCHwWKvUhd+W/YpoAhak5mfnchyl9lEyv9FgTzbjxWMZIwJitSBMLFd
	 GZiNt5Fb/WouWPDCUNyWV1D9BXCcRT2/9/YUL+8j/zO2qcrk/a10Dp3XsHIVWoPvOK
	 Z99ahFepMomNGlIuUFiCn7MZ6hAz4TwKXZhkgkRTgabQgQZA+4CMFdMjK8nvzxmjTs
	 4UrHrDtoU3AXwJlWvWVRidz2c7w1QUCM7zfr3dadIha1BlSUM7Z1TIINJJO2jBep5Y
	 nphHmQHlh6q1qB9Hx1rLrt07IDYSGk1Dze1+hcyi3lJ29c8Bo7tddnxv1FgTnwpXvb
	 ypJDBbI3YkdYA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::733;
 helo=mail-qk1-x733.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=KC3kevDX; dkim-atps=neutral
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCkVY1ZdVz2yJF
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 14:33:24 +1100 (AEDT)
Received: by mail-qk1-x733.google.com with SMTP id de30so15819709qkb.0
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Dec 2021 19:33:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=z89n0bG58WVvUVaWPsozFrWBU2DPTAVTfWJ6jN8VJ2w=;
 b=4zevhqh6wssfDP/PoUJ3hB5mmATtfCbPs9CeK3wVN//TK36Vk+gK9wiyDMSUUjNqjg
 JOhhhh9NcfFvSovcOK5NdUrNfxud0gkfwL/5PCApa+Z8AUqAysFyCXauFLoHrTkgjnhS
 cZHecK9qtqST67fmDhEvFJ5TEpf1ta6XJXHMu4cSaqcy37rAESJ3lkK0oPd1vFf5N6KA
 livcz+c8aT0nf3ftd/nPnLO4YVNfZB6ixCfqdclzmMaawnbCqugRNsMVyAJpBRyB8Cv6
 5Q1nBpXUvbnKFV6DXpGLfjCxdhkiH5VGbS6ACWMa2O4TP4+F0c5FjQzhwwKmA0lvckyo
 Q3cA==
X-Gm-Message-State: AOAM533pxnlrEIt+RpmbpAlIwScQC8fdBVshkp0r4ZgkmkvRDHagD7bC
 4PTBf9don47l8bcJQTdFZK673gCAhwjCxKkSB4uMSqQO3ao=
X-Google-Smtp-Source: ABdhPJwQ9oUUnUuG+73LWj86qA/gBWkKhg+izGW+OtYxDFpxxtUU/+gv29i+ZwIa0fqqdJa8tgGUstb2f6bSLcmm0pI=
X-Received: by 2002:a05:620a:4489:: with SMTP id
 x9mr2054828qkp.38.1639452801984; 
 Mon, 13 Dec 2021 19:33:21 -0800 (PST)
MIME-Version: 1.0
References: <YbgMLtaDEEH+X5/W@B-P7TQMD6M-0146.local>
 <20211214033239.1038379-1-zhangkelvin@google.com>
 <20211214033239.1038379-2-zhangkelvin@google.com>
In-Reply-To: <20211214033239.1038379-2-zhangkelvin@google.com>
Date: Mon, 13 Dec 2021 19:33:10 -0800
Message-ID: <CAOSmRzhXo086gRVfZ7OWTMpm1svO4LU571WSvJUuDBd+84j3Vg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] Add API to iterate over inodes in EROFS
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000e3c27105d312d93a"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--000000000000e3c27105d312d93a
Content-Type: text/plain; charset="UTF-8"

Done, changed that as well. Also added a bit of documentation to note that
parent_nid is optional.

On Mon, Dec 13, 2021 at 7:32 PM Kelvin Zhang <zhangkelvin@google.com> wrote:

> Change-Id: Ia35708080a72ee204eaaddfc670d3cb8023a078c
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>  include/erofs/iterate.h |  46 ++++++++++++
>  include/erofs_fs.h      |   4 +-
>  lib/Makefile.am         |   2 +-
>  lib/iterate.c           | 154 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 203 insertions(+), 3 deletions(-)
>  create mode 100644 include/erofs/iterate.h
>  create mode 100644 lib/iterate.c
>
> diff --git a/include/erofs/iterate.h b/include/erofs/iterate.h
> new file mode 100644
> index 0000000..4e2c783
> --- /dev/null
> +++ b/include/erofs/iterate.h
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: Apache-2.0
> +
> +#ifndef ITERATE_ITERATE
> +#define ITERATE_ITERATE
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +
> +#include "erofs/io.h"
> +#include "erofs/print.h"
> +
> +
> +struct erofs_inode_info {
> +       const char* name;
> +       enum erofs_ftype ftype;
> +       struct erofs_inode* inode;
> +       void* arg;
> +};
> +// Callback function for iterating over inodes of EROFS
> +
> +typedef bool (*erofs_readdir_cb)(struct erofs_inode_info*);
> +
> +// Iterate over inodes that are in directory specified by |nid|.
> +// |parent_nid| is optional, if specified, additional sanity checks will
> +// be performed.
> +// |cb| will be called for every inode, regardless of type of inode.
> +// |arg| will be passed to the callback in |erofs_readdir_cb| struct's
> +// |arg| field.
> +int erofs_iterate_dir(const struct erofs_sb_info* sbi,
> +
> erofs_nid_t nid,
> +
> erofs_nid_t parent_nid,
> +
> erofs_readdir_cb cb,
> +
> void* arg);
> +int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
> +
>                      erofs_readdir_cb cbg,
> +
>                      void* arg);
> +int erofs_get_occupied_size(const struct erofs_inode* inode, erofs_off_t*
> size);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif  // ITERATE_ITERATE
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 9a91877..7ee8251 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -389,8 +389,8 @@ struct erofs_dirent {
>  } __packed;
>
>  /* file types used in inode_info->flags */
> -enum {
> -       EROFS_FT_UNKNOWN,
> +enum erofs_ftype {
> +       EROFS_FT_UNKNOWN = 0,
>         EROFS_FT_REG_FILE,
>         EROFS_FT_DIR,
>         EROFS_FT_CHRDEV,
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 67ba798..20c0e4f 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -27,7 +27,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>  noinst_HEADERS += compressor.h
>  liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c
> exclude.c \
>                       namei.c data.c compress.c compressor.c zmap.c
> decompress.c \
> -                     compress_hints.c hashmap.c sha256.c blobchunk.c
> +                     compress_hints.c hashmap.c sha256.c blobchunk.c
> iterate.c
>  liberofs_la_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
>  if ENABLE_LZ4
>  liberofs_la_CFLAGS += ${LZ4_CFLAGS}
> diff --git a/lib/iterate.c b/lib/iterate.c
> new file mode 100644
> index 0000000..e01eadf
> --- /dev/null
> +++ b/lib/iterate.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: Apache-2.0
> +
> +#include "erofs/internal.h"
> +#include "erofs_fs.h"
> +#include "erofs/print.h"
> +#include "erofs/iterate.h"
> +
> +static int erofs_read_dirent(const struct erofs_sb_info* sbi,
> +
>                                       const struct erofs_dirent* de,
> +
>                                       erofs_nid_t nid,
> +
>                                       erofs_nid_t parent_nid,
> +
>                                       const char* dname,
> +
>                                       erofs_readdir_cb cb,
> +
>                                       void* arg) {
> +       int err;
> +       struct erofs_inode inode = {.nid = de->nid};
> +       err = erofs_read_inode_from_disk(&inode);
> +       if (err) {
> +               erofs_err("read file inode from disk failed!");
> +               return err;
> +       }
> +       char buf[PATH_MAX + 1];
> +       erofs_get_inode_name(sbi, de->nid, buf, PATH_MAX + 1);
> +       struct erofs_inode_info info = {
> +                       .name = buf,
> +                       .ftype = de->file_type,
> +                       .inode = &inode,
> +                       .arg = arg};
> +       cb(&info);
> +       if ((de->file_type == EROFS_FT_DIR) && de->nid != nid &&
> +                       de->nid != parent_nid) {
> +               err = erofs_iterate_dir(sbi, de->nid, nid, cb, arg);
> +               if (err) {
> +                       erofs_err("parse dir nid %u error occurred\n",
> +                                                               (unsigned
> int)(de->nid));
> +                       return err;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static inline int erofs_checkdirent(const struct erofs_dirent* de,
> +
>                                                                      const
> struct erofs_dirent* last_de,
> +
>                                                                      u32
> maxsize,
> +
>                                                                      const
> char* dname) {
> +       int dname_len;
> +       unsigned int nameoff = le16_to_cpu(de->nameoff);
> +       if (nameoff < sizeof(struct erofs_dirent) || nameoff >= PAGE_SIZE)
> {
> +               erofs_err("invalid de[0].nameoff %u @ nid %llu", nameoff,
> de->nid | 0ULL);
> +               return -EFSCORRUPTED;
> +       }
> +       dname_len = (de + 1 >= last_de) ? strnlen(dname, maxsize - nameoff)
> +
>                                                              :
> le16_to_cpu(de[1].nameoff) - nameoff;
> +       /* a corrupted entry is found */
> +       if (nameoff + dname_len > maxsize || dname_len > EROFS_NAME_LEN) {
> +               erofs_err("bogus dirent @ nid %llu", le64_to_cpu(de->nid)
> | 0ULL);
> +               DBG_BUGON(1);
> +               return -EFSCORRUPTED;
> +       }
> +       if (de->file_type >= EROFS_FT_MAX) {
> +               erofs_err("invalid file type %u", (unsigned int)(de->nid));
> +               return -EFSCORRUPTED;
> +       }
> +       return dname_len;
> +}
> +
> +int erofs_iterate_dir(const struct erofs_sb_info* sbi,
> +
> erofs_nid_t nid,
> +
> erofs_nid_t parent_nid,
> +
> erofs_readdir_cb cb,
> +
> void* arg) {
> +       int err;
> +       erofs_off_t offset;
> +       char buf[EROFS_BLKSIZ];
> +       struct erofs_inode vi = {.nid = nid};
> +       err = erofs_read_inode_from_disk(&vi);
> +       if (err)
> +               return err;
> +       struct erofs_inode_info inode_info = {
> +                       .name = buf,
> +                       .ftype = EROFS_FT_DIR,
> +                       .inode = &vi,
> +                       .arg = arg,
> +       };
> +       err = erofs_get_inode_name(sbi, nid, buf, EROFS_BLKSIZ);
> +       cb(&inode_info);
> +       if (err) {
> +               return err;
> +       }
> +       offset = 0;
> +       while (offset < vi.i_size) {
> +               erofs_off_t maxsize = min_t(erofs_off_t, vi.i_size -
> offset, EROFS_BLKSIZ);
> +               const struct erofs_dirent* de = (const struct
> erofs_dirent*)(buf);
> +               struct erofs_dirent* end;
> +               unsigned int nameoff;
> +               err = erofs_pread(&vi, buf, maxsize, offset);
> +               if (err)
> +                       return err;
> +               nameoff = le16_to_cpu(de->nameoff);
> +               end = (struct erofs_dirent*)(buf + nameoff);
> +               while (de < end) {
> +                       const char * const dname = (char*)buf + nameoff;
> +                       int ret;
> +                       /* skip "." and ".." dentry */
> +                       if (is_dot_dotdot(dname)) {
> +                               if (dname[1] == '.' && parent_nid > 0) {
> +                                       // Directory ".." should have nid
> == parent_nid.
> +                                       // But parent_nid parameter is
> optional, so only perform the check
> +                                       // if parent_nid is specified.
> +                                       if (parent_nid != de->nid) {
> +                                               return EFSCORRUPTED;
> +                                       }
> +                               }
> +                               de++;
> +                               continue;
> +                       }
> +                       ret = erofs_checkdirent(de, end, maxsize, dname);
> +                       if (ret < 0)
> +                               return ret;
> +                       ret = erofs_read_dirent(sbi, de, nid, parent_nid,
> dname, cb, arg);
> +                       if (ret < 0)
> +                               return ret;
> +                       ++de;
> +               }
> +               offset += maxsize;
> +       }
> +       return 0;
> +}
> +
> +int erofs_get_occupied_size(const struct erofs_inode* inode, erofs_off_t*
> size) {
> +       *size = 0;
> +       switch (inode->datalayout) {
> +               case EROFS_INODE_FLAT_INLINE:
> +               case EROFS_INODE_FLAT_PLAIN:
> +               case EROFS_INODE_CHUNK_BASED:
> +                       *size = inode->i_size;
> +                       break;
> +               case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
> +               case EROFS_INODE_FLAT_COMPRESSION:
> +                       *size = inode->u.i_blocks * EROFS_BLKSIZ;
> +                       break;
> +               default:
> +                       erofs_err("unknown datalayout");
> +                       return -1;
> +       }
> +       return 0;
> +}
> +
> +int erofs_iterate_root_dir(const struct erofs_sb_info* sbi,
> +
>                      erofs_readdir_cb cb,
> +
>                      void* arg) {
> +       return erofs_iterate_dir(sbi, sbi->root_nid, sbi->root_nid, cb,
> arg);
> +}
> +
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
>

-- 
Sincerely,

Kelvin Zhang

--000000000000e3c27105d312d93a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+RG9uZSwgY2hhbmdlZCB0aGF0IGFzIHdlbGwuIEFsc28gYWRkZWQgYSBi
aXQgb2YgZG9jdW1lbnRhdGlvbiB0byBub3RlIHRoYXQgcGFyZW50X25pZCBpcyBvcHRpb25hbC48
L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBNb24sIERlYyAxMywgMjAyMSBhdCA3OjMyIFBNIEtlbHZpbiBaaGFuZyAm
bHQ7PGEgaHJlZj0ibWFpbHRvOnpoYW5na2VsdmluQGdvb2dsZS5jb20iPnpoYW5na2VsdmluQGdv
b2dsZS5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWls
X3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBz
b2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkNoYW5nZS1JZDogSWEzNTcw
ODA4MGE3MmVlMjA0ZWFhZGRmYzY3MGQzY2I4MDIzYTA3OGM8YnI+DQpTaWduZWQtb2ZmLWJ5OiBL
ZWx2aW4gWmhhbmcgJmx0OzxhIGhyZWY9Im1haWx0bzp6aGFuZ2tlbHZpbkBnb29nbGUuY29tIiB0
YXJnZXQ9Il9ibGFuayI+emhhbmdrZWx2aW5AZ29vZ2xlLmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJy
Pg0KwqBpbmNsdWRlL2Vyb2ZzL2l0ZXJhdGUuaCB8wqAgNDYgKysrKysrKysrKysrPGJyPg0KwqBp
bmNsdWRlL2Vyb2ZzX2ZzLmjCoCDCoCDCoCB8wqAgwqA0ICstPGJyPg0KwqBsaWIvTWFrZWZpbGUu
YW3CoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQrCoGxpYi9pdGVyYXRlLmPCoCDCoCDCoCDC
oCDCoCDCoHwgMTU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKys8YnI+
DQrCoDQgZmlsZXMgY2hhbmdlZCwgMjAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pPGJy
Pg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9lcm9mcy9pdGVyYXRlLmg8YnI+DQrCoGNy
ZWF0ZSBtb2RlIDEwMDY0NCBsaWIvaXRlcmF0ZS5jPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvZXJvZnMvaXRlcmF0ZS5oIGIvaW5jbHVkZS9lcm9mcy9pdGVyYXRlLmg8YnI+DQpuZXcg
ZmlsZSBtb2RlIDEwMDY0NDxicj4NCmluZGV4IDAwMDAwMDAuLjRlMmM3ODM8YnI+DQotLS0gL2Rl
di9udWxsPGJyPg0KKysrIGIvaW5jbHVkZS9lcm9mcy9pdGVyYXRlLmg8YnI+DQpAQCAtMCwwICsx
LDQ2IEBAPGJyPg0KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBBcGFjaGUtMi4wPGJyPg0K
Kzxicj4NCisjaWZuZGVmIElURVJBVEVfSVRFUkFURTxicj4NCisjZGVmaW5lIElURVJBVEVfSVRF
UkFURTxicj4NCis8YnI+DQorI2lmZGVmIF9fY3BsdXNwbHVzPGJyPg0KK2V4dGVybiAmcXVvdDtD
JnF1b3Q7PGJyPg0KK3s8YnI+DQorI2VuZGlmPGJyPg0KKzxicj4NCis8YnI+DQorI2luY2x1ZGUg
JnF1b3Q7ZXJvZnMvaW8uaCZxdW90Ozxicj4NCisjaW5jbHVkZSAmcXVvdDtlcm9mcy9wcmludC5o
JnF1b3Q7PGJyPg0KKzxicj4NCis8YnI+DQorc3RydWN0IGVyb2ZzX2lub2RlX2luZm8gezxicj4N
CivCoCDCoCDCoCDCoGNvbnN0IGNoYXIqIG5hbWU7PGJyPg0KK8KgIMKgIMKgIMKgZW51bSBlcm9m
c19mdHlwZSBmdHlwZTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNfaW5vZGUqIGlub2Rl
Ozxicj4NCivCoCDCoCDCoCDCoHZvaWQqIGFyZzs8YnI+DQorfTs8YnI+DQorLy8gQ2FsbGJhY2sg
ZnVuY3Rpb24gZm9yIGl0ZXJhdGluZyBvdmVyIGlub2RlcyBvZiBFUk9GUzxicj4NCis8YnI+DQor
dHlwZWRlZiBib29sICgqZXJvZnNfcmVhZGRpcl9jYikoc3RydWN0IGVyb2ZzX2lub2RlX2luZm8q
KTs8YnI+DQorPGJyPg0KKy8vIEl0ZXJhdGUgb3ZlciBpbm9kZXMgdGhhdCBhcmUgaW4gZGlyZWN0
b3J5IHNwZWNpZmllZCBieSB8bmlkfC48YnI+DQorLy8gfHBhcmVudF9uaWR8IGlzIG9wdGlvbmFs
LCBpZiBzcGVjaWZpZWQsIGFkZGl0aW9uYWwgc2FuaXR5IGNoZWNrcyB3aWxsPGJyPg0KKy8vIGJl
IHBlcmZvcm1lZC48YnI+DQorLy8gfGNifCB3aWxsIGJlIGNhbGxlZCBmb3IgZXZlcnkgaW5vZGUs
IHJlZ2FyZGxlc3Mgb2YgdHlwZSBvZiBpbm9kZS48YnI+DQorLy8gfGFyZ3wgd2lsbCBiZSBwYXNz
ZWQgdG8gdGhlIGNhbGxiYWNrIGluIHxlcm9mc19yZWFkZGlyX2NifCBzdHJ1Y3QmIzM5O3M8YnI+
DQorLy8gfGFyZ3wgZmllbGQuPGJyPg0KK2ludCBlcm9mc19pdGVyYXRlX2Rpcihjb25zdCBzdHJ1
Y3QgZXJvZnNfc2JfaW5mbyogc2JpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlcm9mc19uaWRfdCBuaWQsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVyb2ZzX25pZF90IHBhcmVu
dF9uaWQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGVyb2ZzX3JlYWRkaXJfY2IgY2IsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZvaWQqIGFyZyk7PGJyPg0KK2ludCBlcm9mc19p
dGVyYXRlX3Jvb3RfZGlyKGNvbnN0IHN0cnVjdCBlcm9mc19zYl9pbmZvKiBzYmksPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNfcmVhZGRpcl9jYiBjYmcsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdm9pZCogYXJnKTs8YnI+DQoraW50IGVyb2ZzX2dl
dF9vY2N1cGllZF9zaXplKGNvbnN0IHN0cnVjdCBlcm9mc19pbm9kZSogaW5vZGUsIGVyb2ZzX29m
Zl90KiBzaXplKTs8YnI+DQorPGJyPg0KKyNpZmRlZiBfX2NwbHVzcGx1czxicj4NCit9PGJyPg0K
KyNlbmRpZjxicj4NCis8YnI+DQorI2VuZGlmwqAgLy8gSVRFUkFURV9JVEVSQVRFPGJyPg0KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvZXJvZnNfZnMuaCBiL2luY2x1ZGUvZXJvZnNfZnMuaDxicj4NCmlu
ZGV4IDlhOTE4NzcuLjdlZTgyNTEgMTAwNjQ0PGJyPg0KLS0tIGEvaW5jbHVkZS9lcm9mc19mcy5o
PGJyPg0KKysrIGIvaW5jbHVkZS9lcm9mc19mcy5oPGJyPg0KQEAgLTM4OSw4ICszODksOCBAQCBz
dHJ1Y3QgZXJvZnNfZGlyZW50IHs8YnI+DQrCoH0gX19wYWNrZWQ7PGJyPg0KPGJyPg0KwqAvKiBm
aWxlIHR5cGVzIHVzZWQgaW4gaW5vZGVfaW5mby0mZ3Q7ZmxhZ3MgKi88YnI+DQotZW51bSB7PGJy
Pg0KLcKgIMKgIMKgIMKgRVJPRlNfRlRfVU5LTk9XTiw8YnI+DQorZW51bSBlcm9mc19mdHlwZSB7
PGJyPg0KK8KgIMKgIMKgIMKgRVJPRlNfRlRfVU5LTk9XTiA9IDAsPGJyPg0KwqAgwqAgwqAgwqAg
RVJPRlNfRlRfUkVHX0ZJTEUsPGJyPg0KwqAgwqAgwqAgwqAgRVJPRlNfRlRfRElSLDxicj4NCsKg
IMKgIMKgIMKgIEVST0ZTX0ZUX0NIUkRFViw8YnI+DQpkaWZmIC0tZ2l0IGEvbGliL01ha2VmaWxl
LmFtIGIvbGliL01ha2VmaWxlLmFtPGJyPg0KaW5kZXggNjdiYTc5OC4uMjBjMGU0ZiAxMDA2NDQ8
YnI+DQotLS0gYS9saWIvTWFrZWZpbGUuYW08YnI+DQorKysgYi9saWIvTWFrZWZpbGUuYW08YnI+
DQpAQCAtMjcsNyArMjcsNyBAQCBub2luc3RfSEVBREVSUyA9ICQodG9wX3NyY2RpcikvaW5jbHVk
ZS9lcm9mc19mcy5oIFw8YnI+DQrCoG5vaW5zdF9IRUFERVJTICs9IGNvbXByZXNzb3IuaDxicj4N
CsKgbGliZXJvZnNfbGFfU09VUkNFUyA9IGNvbmZpZy5jIGlvLmMgY2FjaGUuYyBzdXBlci5jIGlu
b2RlLmMgeGF0dHIuYyBleGNsdWRlLmMgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIG5hbWVpLmMgZGF0YS5jIGNvbXByZXNzLmMgY29tcHJlc3Nvci5jIHptYXAuYyBkZWNv
bXByZXNzLmMgXDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbXByZXNz
X2hpbnRzLmMgaGFzaG1hcC5jIHNoYTI1Ni5jIGJsb2JjaHVuay5jPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgY29tcHJlc3NfaGludHMuYyBoYXNobWFwLmMgc2hhMjU2LmMg
YmxvYmNodW5rLmMgaXRlcmF0ZS5jPGJyPg0KwqBsaWJlcm9mc19sYV9DRkxBR1MgPSAtV2FsbCAt
V2Vycm9yIC1JJCh0b3Bfc3JjZGlyKS9pbmNsdWRlPGJyPg0KwqBpZiBFTkFCTEVfTFo0PGJyPg0K
wqBsaWJlcm9mc19sYV9DRkxBR1MgKz0gJHtMWjRfQ0ZMQUdTfTxicj4NCmRpZmYgLS1naXQgYS9s
aWIvaXRlcmF0ZS5jIGIvbGliL2l0ZXJhdGUuYzxicj4NCm5ldyBmaWxlIG1vZGUgMTAwNjQ0PGJy
Pg0KaW5kZXggMDAwMDAwMC4uZTAxZWFkZjxicj4NCi0tLSAvZGV2L251bGw8YnI+DQorKysgYi9s
aWIvaXRlcmF0ZS5jPGJyPg0KQEAgLTAsMCArMSwxNTQgQEA8YnI+DQorLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEFwYWNoZS0yLjA8YnI+DQorPGJyPg0KKyNpbmNsdWRlICZxdW90O2Vyb2Zz
L2ludGVybmFsLmgmcXVvdDs8YnI+DQorI2luY2x1ZGUgJnF1b3Q7ZXJvZnNfZnMuaCZxdW90Ozxi
cj4NCisjaW5jbHVkZSAmcXVvdDtlcm9mcy9wcmludC5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZx
dW90O2Vyb2ZzL2l0ZXJhdGUuaCZxdW90Ozxicj4NCis8YnI+DQorc3RhdGljIGludCBlcm9mc19y
ZWFkX2RpcmVudChjb25zdCBzdHJ1Y3QgZXJvZnNfc2JfaW5mbyogc2JpLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25zdCBzdHJ1
Y3QgZXJvZnNfZGlyZW50KiBkZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXJvZnNfbmlkX3QgbmlkLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlcm9mc19uaWRfdCBw
YXJlbnRfbmlkLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBjb25zdCBjaGFyKiBkbmFtZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXJvZnNfcmVhZGRpcl9jYiBjYiw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgdm9pZCogYXJnKSB7PGJyPg0KK8KgIMKgIMKgIMKgaW50IGVycjs8YnI+DQorwqAgwqAgwqAg
wqBzdHJ1Y3QgZXJvZnNfaW5vZGUgaW5vZGUgPSB7Lm5pZCA9IGRlLSZndDtuaWR9Ozxicj4NCivC
oCDCoCDCoCDCoGVyciA9IGVyb2ZzX3JlYWRfaW5vZGVfZnJvbV9kaXNrKCZhbXA7aW5vZGUpOzxi
cj4NCivCoCDCoCDCoCDCoGlmIChlcnIpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBl
cm9mc19lcnIoJnF1b3Q7cmVhZCBmaWxlIGlub2RlIGZyb20gZGlzayBmYWlsZWQhJnF1b3Q7KTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gZXJyOzxicj4NCivCoCDCoCDCoCDC
oH08YnI+DQorwqAgwqAgwqAgwqBjaGFyIGJ1ZltQQVRIX01BWCArIDFdOzxicj4NCivCoCDCoCDC
oCDCoGVyb2ZzX2dldF9pbm9kZV9uYW1lKHNiaSwgZGUtJmd0O25pZCwgYnVmLCBQQVRIX01BWCAr
IDEpOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBlcm9mc19pbm9kZV9pbmZvIGluZm8gPSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLm5hbWUgPSBidWYsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmZ0eXBlID0gZGUtJmd0O2ZpbGVf
dHlwZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuaW5vZGUgPSAm
YW1wO2lub2RlLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5hcmcg
PSBhcmd9Ozxicj4NCivCoCDCoCDCoCDCoGNiKCZhbXA7aW5mbyk7PGJyPg0KK8KgIMKgIMKgIMKg
aWYgKChkZS0mZ3Q7ZmlsZV90eXBlID09IEVST0ZTX0ZUX0RJUikgJmFtcDsmYW1wOyBkZS0mZ3Q7
bmlkICE9IG5pZCAmYW1wOyZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZGUtJmd0O25pZCAhPSBwYXJlbnRfbmlkKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZXJyID0gZXJvZnNfaXRlcmF0ZV9kaXIoc2JpLCBkZS0mZ3Q7bmlkLCBuaWQsIGNiLCBh
cmcpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChlcnIpIHs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcm9mc19lcnIoJnF1b3Q7cGFyc2UgZGlyIG5p
ZCAldSBlcnJvciBvY2N1cnJlZFxuJnF1b3Q7LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCh1bnNpZ25lZCBpbnQpKGRlLSZndDtuaWQpKTs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gZXJyOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJu
IDA7PGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRpYyBpbmxpbmUgaW50IGVyb2ZzX2NoZWNrZGly
ZW50KGNvbnN0IHN0cnVjdCBlcm9mc19kaXJlbnQqIGRlLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IHN0cnVjdCBlcm9mc19kaXJlbnQqIGxh
c3RfZGUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
dTMyIG1heHNpemUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgY29uc3QgY2hhciogZG5hbWUpIHs8YnI+DQorwqAgwqAgwqAgwqBpbnQgZG5hbWVfbGVu
Ozxicj4NCivCoCDCoCDCoCDCoHVuc2lnbmVkIGludCBuYW1lb2ZmID0gbGUxNl90b19jcHUoZGUt
Jmd0O25hbWVvZmYpOzxicj4NCivCoCDCoCDCoCDCoGlmIChuYW1lb2ZmICZsdDsgc2l6ZW9mKHN0
cnVjdCBlcm9mc19kaXJlbnQpIHx8IG5hbWVvZmYgJmd0Oz0gUEFHRV9TSVpFKSB7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNfZXJyKCZxdW90O2ludmFsaWQgZGVbMF0ubmFtZW9m
ZiAldSBAIG5pZCAlbGx1JnF1b3Q7LCBuYW1lb2ZmLCBkZS0mZ3Q7bmlkIHwgMFVMTCk7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FRlNDT1JSVVBURUQ7PGJyPg0KK8KgIMKg
IMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoGRuYW1lX2xlbiA9IChkZSArIDEgJmd0Oz0gbGFzdF9k
ZSkgPyBzdHJubGVuKGRuYW1lLCBtYXhzaXplIC0gbmFtZW9mZik8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqA6IGxlMTZfdG9fY3B1KGRlWzFdLm5hbWVvZmYpIC0gbmFtZW9m
Zjs8YnI+DQorwqAgwqAgwqAgwqAvKiBhIGNvcnJ1cHRlZCBlbnRyeSBpcyBmb3VuZCAqLzxicj4N
CivCoCDCoCDCoCDCoGlmIChuYW1lb2ZmICsgZG5hbWVfbGVuICZndDsgbWF4c2l6ZSB8fCBkbmFt
ZV9sZW4gJmd0OyBFUk9GU19OQU1FX0xFTikgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGVyb2ZzX2VycigmcXVvdDtib2d1cyBkaXJlbnQgQCBuaWQgJWxsdSZxdW90OywgbGU2NF90b19j
cHUoZGUtJmd0O25pZCkgfCAwVUxMKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQkdf
QlVHT04oMSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FRlNDT1JSVVBU
RUQ7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoGlmIChkZS0mZ3Q7ZmlsZV90
eXBlICZndDs9IEVST0ZTX0ZUX01BWCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVy
b2ZzX2VycigmcXVvdDtpbnZhbGlkIGZpbGUgdHlwZSAldSZxdW90OywgKHVuc2lnbmVkIGludCko
ZGUtJmd0O25pZCkpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUZTQ09S
UlVQVEVEOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gZG5hbWVf
bGVuOzxicj4NCit9PGJyPg0KKzxicj4NCitpbnQgZXJvZnNfaXRlcmF0ZV9kaXIoY29uc3Qgc3Ry
dWN0IGVyb2ZzX3NiX2luZm8qIHNiaSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXJvZnNfbmlkX3QgbmlkLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlcm9mc19uaWRfdCBwYXJl
bnRfbmlkLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBlcm9mc19yZWFkZGlyX2NiIGNiLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB2b2lkKiBhcmcpIHs8YnI+DQorwqAgwqAgwqAg
wqBpbnQgZXJyOzxicj4NCivCoCDCoCDCoCDCoGVyb2ZzX29mZl90IG9mZnNldDs8YnI+DQorwqAg
wqAgwqAgwqBjaGFyIGJ1ZltFUk9GU19CTEtTSVpdOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBl
cm9mc19pbm9kZSB2aSA9IHsubmlkID0gbmlkfTs8YnI+DQorwqAgwqAgwqAgwqBlcnIgPSBlcm9m
c19yZWFkX2lub2RlX2Zyb21fZGlzaygmYW1wO3ZpKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoZXJy
KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBlcnI7PGJyPg0KK8KgIMKgIMKg
IMKgc3RydWN0IGVyb2ZzX2lub2RlX2luZm8gaW5vZGVfaW5mbyA9IHs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubmFtZSA9IGJ1Ziw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuZnR5cGUgPSBFUk9GU19GVF9ESVIsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmlub2RlID0gJmFtcDt2aSw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuYXJnID0gYXJnLDxicj4NCivCoCDCoCDC
oCDCoH07PGJyPg0KK8KgIMKgIMKgIMKgZXJyID0gZXJvZnNfZ2V0X2lub2RlX25hbWUoc2JpLCBu
aWQsIGJ1ZiwgRVJPRlNfQkxLU0laKTs8YnI+DQorwqAgwqAgwqAgwqBjYigmYW1wO2lub2RlX2lu
Zm8pOzxicj4NCivCoCDCoCDCoCDCoGlmIChlcnIpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXR1cm4gZXJyOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqBvZmZz
ZXQgPSAwOzxicj4NCivCoCDCoCDCoCDCoHdoaWxlIChvZmZzZXQgJmx0OyB2aS5pX3NpemUpIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcm9mc19vZmZfdCBtYXhzaXplID0gbWluX3Qo
ZXJvZnNfb2ZmX3QsIHZpLmlfc2l6ZSAtIG9mZnNldCwgRVJPRlNfQkxLU0laKTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgZXJvZnNfZGlyZW50KiBkZSA9IChjb25z
dCBzdHJ1Y3QgZXJvZnNfZGlyZW50KikoYnVmKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzdHJ1Y3QgZXJvZnNfZGlyZW50KiBlbmQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
dW5zaWduZWQgaW50IG5hbWVvZmY7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJyID0g
ZXJvZnNfcHJlYWQoJmFtcDt2aSwgYnVmLCBtYXhzaXplLCBvZmZzZXQpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGlmIChlcnIpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIGVycjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBuYW1lb2Zm
ID0gbGUxNl90b19jcHUoZGUtJmd0O25hbWVvZmYpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGVuZCA9IChzdHJ1Y3QgZXJvZnNfZGlyZW50KikoYnVmICsgbmFtZW9mZik7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgd2hpbGUgKGRlICZsdDsgZW5kKSB7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29uc3QgY2hhciAqIGNvbnN0IGRuYW1lID0gKGNo
YXIqKWJ1ZiArIG5hbWVvZmY7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaW50IHJldDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBz
a2lwICZxdW90Oy4mcXVvdDsgYW5kICZxdW90Oy4uJnF1b3Q7IGRlbnRyeSAqLzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChpc19kb3RfZG90ZG90KGRuYW1lKSkg
ezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChkbmFtZVsxXSA9PSAmIzM5Oy4mIzM5OyAmYW1wOyZhbXA7IHBhcmVudF9uaWQgJmd0OyAwKSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgLy8gRGlyZWN0b3J5ICZxdW90Oy4uJnF1b3Q7IHNob3VsZCBoYXZlIG5pZCA9PSBw
YXJlbnRfbmlkLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC8vIEJ1dCBwYXJlbnRfbmlkIHBhcmFtZXRlciBpcyBvcHRpb25h
bCwgc28gb25seSBwZXJmb3JtIHRoZSBjaGVjazxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8vIGlmIHBhcmVudF9uaWQgaXMg
c3BlY2lmaWVkLjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmIChwYXJlbnRfbmlkICE9IGRlLSZndDtuaWQpIHs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gRUZTQ09SUlVQVEVEOzxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGUrKzs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51ZTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0ID0gZXJvZnNfY2hlY2tkaXJlbnQoZGUsIGVuZCwgbWF4
c2l6ZSwgZG5hbWUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChyZXQgJmx0OyAwKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiByZXQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0ID0gZXJvZnNfcmVhZF9kaXJlbnQoc2JpLCBkZSwgbmlkLCBwYXJlbnRfbmlkLCBk
bmFtZSwgY2IsIGFyZyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgKHJldCAmbHQ7IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqArK2RlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBvZmZzZXQgKz0gbWF4c2l6ZTs8YnI+DQorwqAgwqAgwqAgwqB9PGJy
Pg0KK8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KK308YnI+DQorPGJyPg0KK2ludCBlcm9mc19n
ZXRfb2NjdXBpZWRfc2l6ZShjb25zdCBzdHJ1Y3QgZXJvZnNfaW5vZGUqIGlub2RlLCBlcm9mc19v
ZmZfdCogc2l6ZSkgezxicj4NCivCoCDCoCDCoCDCoCpzaXplID0gMDs8YnI+DQorwqAgwqAgwqAg
wqBzd2l0Y2ggKGlub2RlLSZndDtkYXRhbGF5b3V0KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgY2FzZSBFUk9GU19JTk9ERV9GTEFUX0lOTElORTo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjYXNlIEVST0ZTX0lOT0RFX0ZMQVRfUExBSU46PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY2FzZSBFUk9GU19JTk9ERV9DSFVOS19CQVNFRDo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqc2l6ZSA9IGlub2RlLSZndDtpX3NpemU7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY2FzZSBFUk9GU19JTk9ERV9GTEFUX0NPTVBSRVNTSU9OX0xFR0FDWTo8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEVST0ZTX0lOT0RFX0ZMQVRfQ09NUFJFU1NJ
T046PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKnNpemUgPSBpbm9k
ZS0mZ3Q7dS5pX2Jsb2NrcyAqIEVST0ZTX0JMS1NJWjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZh
dWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyb2ZzX2Vycigm
cXVvdDt1bmtub3duIGRhdGFsYXlvdXQmcXVvdDspOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKg
IMKgIMKgcmV0dXJuIDA7PGJyPg0KK308YnI+DQorPGJyPg0KK2ludCBlcm9mc19pdGVyYXRlX3Jv
b3RfZGlyKGNvbnN0IHN0cnVjdCBlcm9mc19zYl9pbmZvKiBzYmksPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNfcmVhZGRpcl9jYiBjYiw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB2b2lkKiBhcmcpIHs8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gZXJv
ZnNfaXRlcmF0ZV9kaXIoc2JpLCBzYmktJmd0O3Jvb3RfbmlkLCBzYmktJmd0O3Jvb3RfbmlkLCBj
YiwgYXJnKTs8YnI+DQorfTxicj4NCis8YnI+DQotLSA8YnI+DQoyLjM0LjEuMTczLmc3NmFhOGJj
MmQwLWdvb2c8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PGJyIGNsZWFyPSJhbGwiPjxk
aXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfc2lnbmF0dXJl
Ij48ZGl2IGRpcj0ibHRyIj5TaW5jZXJlbHksPGRpdj48YnI+PC9kaXY+PGRpdj5LZWx2aW4gWmhh
bmc8L2Rpdj48L2Rpdj48L2Rpdj4NCg==
--000000000000e3c27105d312d93a--
