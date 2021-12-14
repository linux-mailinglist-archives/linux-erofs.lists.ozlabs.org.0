Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C75E2473AB9
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 03:25:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JCj0C4xrPz3036
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Dec 2021 13:25:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639448731;
	bh=xgC+fsFCw2dDEK0TbOSnlIeKfI04in5q3O+4l8AXBLE=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Fz3LE3ceJBKUD93vzdzVbDfSLNftU9qMf+29ZIka1yWsojeV3jpD9OIQ3vjp0q5OT
	 D739MH0XmmIO/pFzcBZZeB7RkCPZI5w+4NKI188UYp+iB5OA03M8XsK37rynzrS95S
	 koXq1SwEusxgadUjSoR1/rClfueRwOZildroRs4I0UMVO/O4b9FuCbus/GdG/lgfIA
	 eNn/M1ZaVTpFR07IKy+ougzqCZlYEjsI40XJZT5GwbyKScLaElHf5C5+Wh1DjvaQtg
	 bUL2+dmK18WFKvrQU7lBoX7cIiVqxIdcDbYH1fPFQuHg2339OMpJHM12QaoYiHp4YG
	 r6+wuurvap+yw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::829;
 helo=mail-qt1-x829.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=mx6Pfnh+; dkim-atps=neutral
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JCj063srcz2yXM
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Dec 2021 13:25:24 +1100 (AEDT)
Received: by mail-qt1-x829.google.com with SMTP id q14so17176924qtx.10
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Dec 2021 18:25:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xgC+fsFCw2dDEK0TbOSnlIeKfI04in5q3O+4l8AXBLE=;
 b=FyW1ZnXNhbW9cbKLppUCrp47buL3VgdZiryruILlI6PHGzVO8hvSN3lCj7WSKT13As
 3v5GS2snlx8n9zHfFiWk0uZMVYc08hE4trpYleO3yEs8hGR03MzzHGgl+Ji0UMQrjorX
 EOk1vAcGrgkH0Ka33jTX2gVLSH/7qm/4xVecB0uPx559ItJGL2myolopnhnLD/3Il7g9
 bCABj+mva15o0pLBDmh9CHA/OW8RWvLeSerBdjxSmComlykXh35O7I512HZRT31BgOFy
 pWW1bYcZehY5x194LvmpBUV4xvKtZpF8ycEesaypxCqso/c0ESp6ZTRv5pOocK8L2V4Y
 sNQQ==
X-Gm-Message-State: AOAM530pZ+x2oL3ETYUnw6aMUvJQjs/vvpA4m6QGC2hdutfjFXu7SBRR
 HGxaWogFuyygiHdXI0g902s5MBUlTNPLZOrzpK9n+5ZUeboMtA==
X-Google-Smtp-Source: ABdhPJzc1waz2fyxLeGWWj5qbJ+M2Gl0eF6PvJHhfXXGLFoSxDLLfeqniaYoPfkFMNcbnapqkeOuzq3ANP1SXTV4R9k=
X-Received: by 2002:ac8:5c50:: with SMTP id j16mr2814056qtj.255.1639448720875; 
 Mon, 13 Dec 2021 18:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20211214004311.GA2891@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20211214021955.992899-1-zhangkelvin@google.com>
 <20211214021955.992899-2-zhangkelvin@google.com>
In-Reply-To: <20211214021955.992899-2-zhangkelvin@google.com>
Date: Mon, 13 Dec 2021 18:25:09 -0800
Message-ID: <CAOSmRzjd4j+Zus+cnor+X0bwMbdBGp4V=Pm89Co0_BeH=mt6FQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Add API to iterate over inodes in EROFS
To: linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000a2f07005d311e688"
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

--000000000000a2f07005d311e688
Content-Type: text/plain; charset="UTF-8"

Fixed most of the issues you pointed out. Except I didn't quite understand
the "nid is optional unless we do a fsck." part. Not sure how we can
implement the iterate dir function w/o nid. Can you provide more context?

On Mon, Dec 13, 2021 at 6:20 PM Kelvin Zhang <zhangkelvin@google.com> wrote:

> Change-Id: Ia35708080a72ee204eaaddfc670d3cb8023a078c
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>  include/erofs/iterate.h |  40 +++++++++++
>  include/erofs_fs.h      |   4 +-
>  lib/Makefile.am         |   2 +-
>  lib/iterate.c           | 148 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 191 insertions(+), 3 deletions(-)
>  create mode 100644 include/erofs/iterate.h
>  create mode 100644 lib/iterate.c
>
> diff --git a/include/erofs/iterate.h b/include/erofs/iterate.h
> new file mode 100644
> index 0000000..af29e14
> --- /dev/null
> +++ b/include/erofs/iterate.h
> @@ -0,0 +1,40 @@
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
> +int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size);
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
> index 0000000..ec44217
> --- /dev/null
> +++ b/lib/iterate.c
> @@ -0,0 +1,148 @@
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
> +       erofs_off_t occupied_size = 0;
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
> +                       const char* dname;
> +                       int ret;
> +                       /* skip "." and ".." dentry */
> +                       if (de->nid == nid || de->nid == parent_nid) {
> +                               de++;
> +                               continue;
> +                       }
> +                       dname = (char*)buf + nameoff;
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
> +int erofs_get_occupied_size(struct erofs_inode* inode, erofs_off_t* size)
> {
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

--000000000000a2f07005d311e688
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+Rml4ZWQgbW9zdCBvZiB0aGUgaXNzdWVzIHlvdSBwb2ludGVkIG91dC4g
RXhjZXB0IEkgZGlkbiYjMzk7dCBxdWl0ZSB1bmRlcnN0YW5kIHRoZSAmcXVvdDtuaWQgaXMgb3B0
aW9uYWwgdW5sZXNzIHdlIGRvIGEgZnNjay4mcXVvdDsgcGFydC4gTm90IHN1cmUgaG93IHdlIGNh
biBpbXBsZW1lbnQgdGhlIGl0ZXJhdGUgZGlyIGZ1bmN0aW9uIHcvbyBuaWQuIENhbiB5b3UgcHJv
dmlkZSBtb3JlIGNvbnRleHQ/PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+
PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgRGVjIDEzLCAyMDIxIGF0
IDY6MjAgUE0gS2VsdmluIFpoYW5nICZsdDs8YSBocmVmPSJtYWlsdG86emhhbmdrZWx2aW5AZ29v
Z2xlLmNvbSI+emhhbmdrZWx2aW5AZ29vZ2xlLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48
YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHgg
MC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0
OjFleCI+Q2hhbmdlLUlkOiBJYTM1NzA4MDgwYTcyZWUyMDRlYWFkZGZjNjcwZDNjYjgwMjNhMDc4
Yzxicj4NClNpZ25lZC1vZmYtYnk6IEtlbHZpbiBaaGFuZyAmbHQ7PGEgaHJlZj0ibWFpbHRvOnpo
YW5na2VsdmluQGdvb2dsZS5jb20iIHRhcmdldD0iX2JsYW5rIj56aGFuZ2tlbHZpbkBnb29nbGUu
Y29tPC9hPiZndDs8YnI+DQotLS08YnI+DQrCoGluY2x1ZGUvZXJvZnMvaXRlcmF0ZS5oIHzCoCA0
MCArKysrKysrKysrKzxicj4NCsKgaW5jbHVkZS9lcm9mc19mcy5owqAgwqAgwqAgfMKgIMKgNCAr
LTxicj4NCsKgbGliL01ha2VmaWxlLmFtwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KwqBs
aWIvaXRlcmF0ZS5jwqAgwqAgwqAgwqAgwqAgwqB8IDE0OCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrPGJyPg0KwqA0IGZpbGVzIGNoYW5nZWQsIDE5MSBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKTxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZXJv
ZnMvaXRlcmF0ZS5oPGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgbGliL2l0ZXJhdGUuYzxicj4N
Cjxicj4NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2Vyb2ZzL2l0ZXJhdGUuaCBiL2luY2x1ZGUvZXJv
ZnMvaXRlcmF0ZS5oPGJyPg0KbmV3IGZpbGUgbW9kZSAxMDA2NDQ8YnI+DQppbmRleCAwMDAwMDAw
Li5hZjI5ZTE0PGJyPg0KLS0tIC9kZXYvbnVsbDxicj4NCisrKyBiL2luY2x1ZGUvZXJvZnMvaXRl
cmF0ZS5oPGJyPg0KQEAgLTAsMCArMSw0MCBAQDxicj4NCisvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogQXBhY2hlLTIuMDxicj4NCis8YnI+DQorI2lmbmRlZiBJVEVSQVRFX0lURVJBVEU8YnI+
DQorI2RlZmluZSBJVEVSQVRFX0lURVJBVEU8YnI+DQorPGJyPg0KKyNpZmRlZiBfX2NwbHVzcGx1
czxicj4NCitleHRlcm4gJnF1b3Q7QyZxdW90Ozxicj4NCit7PGJyPg0KKyNlbmRpZjxicj4NCis8
YnI+DQorPGJyPg0KKyNpbmNsdWRlICZxdW90O2Vyb2ZzL2lvLmgmcXVvdDs8YnI+DQorI2luY2x1
ZGUgJnF1b3Q7ZXJvZnMvcHJpbnQuaCZxdW90Ozxicj4NCis8YnI+DQorPGJyPg0KK3N0cnVjdCBl
cm9mc19pbm9kZV9pbmZvIHs8YnI+DQorwqAgwqAgwqAgwqBjb25zdCBjaGFyKiBuYW1lOzxicj4N
CivCoCDCoCDCoCDCoGVudW0gZXJvZnNfZnR5cGUgZnR5cGU7PGJyPg0KK8KgIMKgIMKgIMKgc3Ry
dWN0IGVyb2ZzX2lub2RlKiBpbm9kZTs8YnI+DQorwqAgwqAgwqAgwqB2b2lkKiBhcmc7PGJyPg0K
K307PGJyPg0KKy8vIENhbGxiYWNrIGZ1bmN0aW9uIGZvciBpdGVyYXRpbmcgb3ZlciBpbm9kZXMg
b2YgRVJPRlM8YnI+DQorPGJyPg0KK3R5cGVkZWYgYm9vbCAoKmVyb2ZzX3JlYWRkaXJfY2IpKHN0
cnVjdCBlcm9mc19pbm9kZV9pbmZvKik7PGJyPg0KKzxicj4NCitpbnQgZXJvZnNfaXRlcmF0ZV9k
aXIoY29uc3Qgc3RydWN0IGVyb2ZzX3NiX2luZm8qIHNiaSw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXJvZnNfbmlkX3QgbmlkLDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlcm9m
c19uaWRfdCBwYXJlbnRfbmlkLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBlcm9mc19yZWFkZGlyX2NiIGNiLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB2b2lkKiBhcmcpOzxicj4N
CitpbnQgZXJvZnNfaXRlcmF0ZV9yb290X2Rpcihjb25zdCBzdHJ1Y3QgZXJvZnNfc2JfaW5mbyog
c2JpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyb2ZzX3JlYWRkaXJfY2Ig
Y2JnLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZvaWQqIGFyZyk7PGJyPg0K
K2ludCBlcm9mc19nZXRfb2NjdXBpZWRfc2l6ZShzdHJ1Y3QgZXJvZnNfaW5vZGUqIGlub2RlLCBl
cm9mc19vZmZfdCogc2l6ZSk7PGJyPg0KKzxicj4NCisjaWZkZWYgX19jcGx1c3BsdXM8YnI+DQor
fTxicj4NCisjZW5kaWY8YnI+DQorPGJyPg0KKyNlbmRpZsKgIC8vIElURVJBVEVfSVRFUkFURTxi
cj4NCmRpZmYgLS1naXQgYS9pbmNsdWRlL2Vyb2ZzX2ZzLmggYi9pbmNsdWRlL2Vyb2ZzX2ZzLmg8
YnI+DQppbmRleCA5YTkxODc3Li43ZWU4MjUxIDEwMDY0NDxicj4NCi0tLSBhL2luY2x1ZGUvZXJv
ZnNfZnMuaDxicj4NCisrKyBiL2luY2x1ZGUvZXJvZnNfZnMuaDxicj4NCkBAIC0zODksOCArMzg5
LDggQEAgc3RydWN0IGVyb2ZzX2RpcmVudCB7PGJyPg0KwqB9IF9fcGFja2VkOzxicj4NCjxicj4N
CsKgLyogZmlsZSB0eXBlcyB1c2VkIGluIGlub2RlX2luZm8tJmd0O2ZsYWdzICovPGJyPg0KLWVu
dW0gezxicj4NCi3CoCDCoCDCoCDCoEVST0ZTX0ZUX1VOS05PV04sPGJyPg0KK2VudW0gZXJvZnNf
ZnR5cGUgezxicj4NCivCoCDCoCDCoCDCoEVST0ZTX0ZUX1VOS05PV04gPSAwLDxicj4NCsKgIMKg
IMKgIMKgIEVST0ZTX0ZUX1JFR19GSUxFLDxicj4NCsKgIMKgIMKgIMKgIEVST0ZTX0ZUX0RJUiw8
YnI+DQrCoCDCoCDCoCDCoCBFUk9GU19GVF9DSFJERVYsPGJyPg0KZGlmZiAtLWdpdCBhL2xpYi9N
YWtlZmlsZS5hbSBiL2xpYi9NYWtlZmlsZS5hbTxicj4NCmluZGV4IDY3YmE3OTguLjIwYzBlNGYg
MTAwNjQ0PGJyPg0KLS0tIGEvbGliL01ha2VmaWxlLmFtPGJyPg0KKysrIGIvbGliL01ha2VmaWxl
LmFtPGJyPg0KQEAgLTI3LDcgKzI3LDcgQEAgbm9pbnN0X0hFQURFUlMgPSAkKHRvcF9zcmNkaXIp
L2luY2x1ZGUvZXJvZnNfZnMuaCBcPGJyPg0KwqBub2luc3RfSEVBREVSUyArPSBjb21wcmVzc29y
Lmg8YnI+DQrCoGxpYmVyb2ZzX2xhX1NPVVJDRVMgPSBjb25maWcuYyBpby5jIGNhY2hlLmMgc3Vw
ZXIuYyBpbm9kZS5jIHhhdHRyLmMgZXhjbHVkZS5jIFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBuYW1laS5jIGRhdGEuYyBjb21wcmVzcy5jIGNvbXByZXNzb3IuYyB6bWFw
LmMgZGVjb21wcmVzcy5jIFw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBj
b21wcmVzc19oaW50cy5jIGhhc2htYXAuYyBzaGEyNTYuYyBibG9iY2h1bmsuYzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbXByZXNzX2hpbnRzLmMgaGFzaG1hcC5jIHNo
YTI1Ni5jIGJsb2JjaHVuay5jIGl0ZXJhdGUuYzxicj4NCsKgbGliZXJvZnNfbGFfQ0ZMQUdTID0g
LVdhbGwgLVdlcnJvciAtSSQodG9wX3NyY2RpcikvaW5jbHVkZTxicj4NCsKgaWYgRU5BQkxFX0xa
NDxicj4NCsKgbGliZXJvZnNfbGFfQ0ZMQUdTICs9ICR7TFo0X0NGTEFHU308YnI+DQpkaWZmIC0t
Z2l0IGEvbGliL2l0ZXJhdGUuYyBiL2xpYi9pdGVyYXRlLmM8YnI+DQpuZXcgZmlsZSBtb2RlIDEw
MDY0NDxicj4NCmluZGV4IDAwMDAwMDAuLmVjNDQyMTc8YnI+DQotLS0gL2Rldi9udWxsPGJyPg0K
KysrIGIvbGliL2l0ZXJhdGUuYzxicj4NCkBAIC0wLDAgKzEsMTQ4IEBAPGJyPg0KKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBBcGFjaGUtMi4wPGJyPg0KKzxicj4NCisjaW5jbHVkZSAmcXVv
dDtlcm9mcy9pbnRlcm5hbC5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZxdW90O2Vyb2ZzX2ZzLmgm
cXVvdDs8YnI+DQorI2luY2x1ZGUgJnF1b3Q7ZXJvZnMvcHJpbnQuaCZxdW90Ozxicj4NCisjaW5j
bHVkZSAmcXVvdDtlcm9mcy9pdGVyYXRlLmgmcXVvdDs8YnI+DQorPGJyPg0KK3N0YXRpYyBpbnQg
ZXJvZnNfcmVhZF9kaXJlbnQoY29uc3Qgc3RydWN0IGVyb2ZzX3NiX2luZm8qIHNiaSw8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29u
c3Qgc3RydWN0IGVyb2ZzX2RpcmVudCogZGUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVyb2ZzX25pZF90IG5pZCw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXJvZnNf
bmlkX3QgcGFyZW50X25pZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3QgY2hhciogZG5hbWUsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVyb2ZzX3JlYWRkaXJf
Y2IgY2IsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHZvaWQqIGFyZykgezxicj4NCivCoCDCoCDCoCDCoGludCBlcnI7PGJyPg0KK8Kg
IMKgIMKgIMKgZXJvZnNfb2ZmX3Qgb2NjdXBpZWRfc2l6ZSA9IDA7PGJyPg0KK8KgIMKgIMKgIMKg
c3RydWN0IGVyb2ZzX2lub2RlIGlub2RlID0gey5uaWQgPSBkZS0mZ3Q7bmlkfTs8YnI+DQorwqAg
wqAgwqAgwqBlcnIgPSBlcm9mc19yZWFkX2lub2RlX2Zyb21fZGlzaygmYW1wO2lub2RlKTs8YnI+
DQorwqAgwqAgwqAgwqBpZiAoZXJyKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJv
ZnNfZXJyKCZxdW90O3JlYWQgZmlsZSBpbm9kZSBmcm9tIGRpc2sgZmFpbGVkISZxdW90Oyk7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGVycjs8YnI+DQorwqAgwqAgwqAgwqB9
PGJyPg0KK8KgIMKgIMKgIMKgY2hhciBidWZbUEFUSF9NQVggKyAxXTs8YnI+DQorwqAgwqAgwqAg
wqBlcm9mc19nZXRfaW5vZGVfbmFtZShzYmksIGRlLSZndDtuaWQsIGJ1ZiwgUEFUSF9NQVggKyAx
KTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZXJvZnNfaW5vZGVfaW5mbyBpbmZvID0gezxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5uYW1lID0gYnVmLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5mdHlwZSA9IGRlLSZndDtmaWxlX3R5
cGUsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmlub2RlID0gJmFt
cDtpbm9kZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAuYXJnID0g
YXJnfTs8YnI+DQorwqAgwqAgwqAgwqBjYigmYW1wO2luZm8pOzxicj4NCivCoCDCoCDCoCDCoGlm
ICgoZGUtJmd0O2ZpbGVfdHlwZSA9PSBFUk9GU19GVF9ESVIpICZhbXA7JmFtcDsgZGUtJmd0O25p
ZCAhPSBuaWQgJmFtcDsmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGRlLSZndDtuaWQgIT0gcGFyZW50X25pZCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGVyciA9IGVyb2ZzX2l0ZXJhdGVfZGlyKHNiaSwgZGUtJmd0O25pZCwgbmlkLCBjYiwgYXJn
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZXJyKSB7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNfZXJyKCZxdW90O3BhcnNlIGRpciBuaWQg
JXUgZXJyb3Igb2NjdXJyZWRcbiZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAodW5zaWduZWQgaW50KShkZS0mZ3Q7bmlkKSk7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIGVycjs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoHJldHVybiAw
Ozxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgaW5saW5lIGludCBlcm9mc19jaGVja2RpcmVu
dChjb25zdCBzdHJ1Y3QgZXJvZnNfZGlyZW50KiBkZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgZXJvZnNfZGlyZW50KiBsYXN0
X2RlLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHUz
MiBtYXhzaXplLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGNvbnN0IGNoYXIqIGRuYW1lKSB7PGJyPg0KK8KgIMKgIMKgIMKgaW50IGRuYW1lX2xlbjs8
YnI+DQorwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgbmFtZW9mZiA9IGxlMTZfdG9fY3B1KGRlLSZn
dDtuYW1lb2ZmKTs8YnI+DQorwqAgwqAgwqAgwqBpZiAobmFtZW9mZiAmbHQ7IHNpemVvZihzdHJ1
Y3QgZXJvZnNfZGlyZW50KSB8fCBuYW1lb2ZmICZndDs9IFBBR0VfU0laRSkgezxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGVyb2ZzX2VycigmcXVvdDtpbnZhbGlkIGRlWzBdLm5hbWVvZmYg
JXUgQCBuaWQgJWxsdSZxdW90OywgbmFtZW9mZiwgZGUtJmd0O25pZCB8IDBVTEwpOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUZTQ09SUlVQVEVEOzxicj4NCivCoCDCoCDC
oCDCoH08YnI+DQorwqAgwqAgwqAgwqBkbmFtZV9sZW4gPSAoZGUgKyAxICZndDs9IGxhc3RfZGUp
ID8gc3RybmxlbihkbmFtZSwgbWF4c2l6ZSAtIG5hbWVvZmYpPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgOiBsZTE2X3RvX2NwdShkZVsxXS5uYW1lb2ZmKSAtIG5hbWVvZmY7
PGJyPg0KK8KgIMKgIMKgIMKgLyogYSBjb3JydXB0ZWQgZW50cnkgaXMgZm91bmQgKi88YnI+DQor
wqAgwqAgwqAgwqBpZiAobmFtZW9mZiArIGRuYW1lX2xlbiAmZ3Q7IG1heHNpemUgfHwgZG5hbWVf
bGVuICZndDsgRVJPRlNfTkFNRV9MRU4pIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBl
cm9mc19lcnIoJnF1b3Q7Ym9ndXMgZGlyZW50IEAgbmlkICVsbHUmcXVvdDssIGxlNjRfdG9fY3B1
KGRlLSZndDtuaWQpIHwgMFVMTCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgREJHX0JV
R09OKDEpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUZTQ09SUlVQVEVE
Ozxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqBpZiAoZGUtJmd0O2ZpbGVfdHlw
ZSAmZ3Q7PSBFUk9GU19GVF9NQVgpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcm9m
c19lcnIoJnF1b3Q7aW52YWxpZCBmaWxlIHR5cGUgJXUmcXVvdDssICh1bnNpZ25lZCBpbnQpKGRl
LSZndDtuaWQpKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gLUVGU0NPUlJV
UFRFRDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIGRuYW1lX2xl
bjs8YnI+DQorfTxicj4NCis8YnI+DQoraW50IGVyb2ZzX2l0ZXJhdGVfZGlyKGNvbnN0IHN0cnVj
dCBlcm9mc19zYl9pbmZvKiBzYmksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIGVyb2ZzX25pZF90IG5pZCw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZXJvZnNfbmlkX3QgcGFyZW50
X25pZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZXJvZnNfcmVhZGRpcl9jYiBjYiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdm9pZCogYXJnKSB7PGJyPg0KK8KgIMKgIMKgIMKg
aW50IGVycjs8YnI+DQorwqAgwqAgwqAgwqBlcm9mc19vZmZfdCBvZmZzZXQ7PGJyPg0KK8KgIMKg
IMKgIMKgY2hhciBidWZbRVJPRlNfQkxLU0laXTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZXJv
ZnNfaW5vZGUgdmkgPSB7Lm5pZCA9IG5pZH07PGJyPg0KK8KgIMKgIMKgIMKgZXJyID0gZXJvZnNf
cmVhZF9pbm9kZV9mcm9tX2Rpc2soJmFtcDt2aSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKGVycik8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gZXJyOzxicj4NCivCoCDCoCDCoCDC
oHN0cnVjdCBlcm9mc19pbm9kZV9pbmZvIGlub2RlX2luZm8gPSB7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLm5hbWUgPSBidWYsPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLmZ0eXBlID0gRVJPRlNfRlRfRElSLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5pbm9kZSA9ICZhbXA7dmksPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmFyZyA9IGFyZyw8YnI+DQorwqAgwqAgwqAg
wqB9Ozxicj4NCivCoCDCoCDCoCDCoGVyciA9IGVyb2ZzX2dldF9pbm9kZV9uYW1lKHNiaSwgbmlk
LCBidWYsIEVST0ZTX0JMS1NJWik7PGJyPg0KK8KgIMKgIMKgIMKgY2IoJmFtcDtpbm9kZV9pbmZv
KTs8YnI+DQorwqAgwqAgwqAgwqBpZiAoZXJyKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIGVycjs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgb2Zmc2V0
ID0gMDs8YnI+DQorwqAgwqAgwqAgwqB3aGlsZSAob2Zmc2V0ICZsdDsgdmkuaV9zaXplKSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNfb2ZmX3QgbWF4c2l6ZSA9IG1pbl90KGVy
b2ZzX29mZl90LCB2aS5pX3NpemUgLSBvZmZzZXQsIEVST0ZTX0JMS1NJWik7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgY29uc3Qgc3RydWN0IGVyb2ZzX2RpcmVudCogZGUgPSAoY29uc3Qg
c3RydWN0IGVyb2ZzX2RpcmVudCopKGJ1Zik7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3RydWN0IGVyb2ZzX2RpcmVudCogZW5kOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHVu
c2lnbmVkIGludCBuYW1lb2ZmOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVyciA9IGVy
b2ZzX3ByZWFkKCZhbXA7dmksIGJ1ZiwgbWF4c2l6ZSwgb2Zmc2V0KTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoZXJyKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybiBlcnI7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbmFtZW9mZiA9
IGxlMTZfdG9fY3B1KGRlLSZndDtuYW1lb2ZmKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBlbmQgPSAoc3RydWN0IGVyb2ZzX2RpcmVudCopKGJ1ZiArIG5hbWVvZmYpOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHdoaWxlIChkZSAmbHQ7IGVuZCkgezxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IGNoYXIqIGRuYW1lOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludCByZXQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogc2tpcCAmcXVvdDsuJnF1b3Q7IGFuZCAmcXVvdDsuLiZx
dW90OyBkZW50cnkgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAoZGUtJmd0O25pZCA9PSBuaWQgfHwgZGUtJmd0O25pZCA9PSBwYXJlbnRfbmlkKSB7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGUrKzs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb250aW51
ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZG5hbWUgPSAoY2hhciopYnVmICsgbmFtZW9m
Zjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBlcm9mc19j
aGVja2RpcmVudChkZSwgZW5kLCBtYXhzaXplLCBkbmFtZSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldCAmbHQ7IDApPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJldDs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBlcm9mc19yZWFkX2RpcmVudChzYmks
IGRlLCBuaWQsIHBhcmVudF9uaWQsIGRuYW1lLCBjYiwgYXJnKTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCk8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsrZGU7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9mZnNldCArPSBtYXhzaXpl
Ozxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQorfTxi
cj4NCis8YnI+DQoraW50IGVyb2ZzX2dldF9vY2N1cGllZF9zaXplKHN0cnVjdCBlcm9mc19pbm9k
ZSogaW5vZGUsIGVyb2ZzX29mZl90KiBzaXplKSB7PGJyPg0KK8KgIMKgIMKgIMKgKnNpemUgPSAw
Ozxicj4NCivCoCDCoCDCoCDCoHN3aXRjaCAoaW5vZGUtJmd0O2RhdGFsYXlvdXQpIHs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEVST0ZTX0lOT0RFX0ZMQVRfSU5MSU5FOjxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgRVJPRlNfSU5PREVfRkxBVF9QTEFJTjo8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEVST0ZTX0lOT0RFX0NIVU5LX0JBU0VEOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCpzaXplID0gaW5vZGUtJmd0
O2lfc2l6ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEVST0ZTX0lOT0RFX0ZMQVRfQ09NUFJF
U1NJT05fTEVHQUNZOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgRVJPRlNfSU5P
REVfRkxBVF9DT01QUkVTU0lPTjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAqc2l6ZSA9IGlub2RlLSZndDt1LmlfYmxvY2tzICogRVJPRlNfQkxLU0laOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZXJvZnNfZXJyKCZxdW90O3Vua25vd24gZGF0YWxheW91dCZxdW90Oyk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC0xOzxicj4NCivCoCDCoCDC
oCDCoH08YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQorfTxicj4NCis8YnI+DQoraW50
IGVyb2ZzX2l0ZXJhdGVfcm9vdF9kaXIoY29uc3Qgc3RydWN0IGVyb2ZzX3NiX2luZm8qIHNiaSw8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlcm9mc19yZWFkZGlyX2NiIGNiLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHZvaWQqIGFyZykgezxicj4NCivCoCDC
oCDCoCDCoHJldHVybiBlcm9mc19pdGVyYXRlX2RpcihzYmksIHNiaS0mZ3Q7cm9vdF9uaWQsIHNi
aS0mZ3Q7cm9vdF9uaWQsIGNiLCBhcmcpOzxicj4NCit9PGJyPg0KKzxicj4NCi0tIDxicj4NCjIu
MzQuMS4xNzMuZzc2YWE4YmMyZDAtZ29vZzxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48L2Rpdj48
YnIgY2xlYXI9ImFsbCI+PGRpdj48YnI+PC9kaXY+LS0gPGJyPjxkaXYgZGlyPSJsdHIiIGNsYXNz
PSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPlNpbmNlcmVseSw8ZGl2Pjxicj48L2Rp
dj48ZGl2PktlbHZpbiBaaGFuZzwvZGl2PjwvZGl2PjwvZGl2Pg0K
--000000000000a2f07005d311e688--
