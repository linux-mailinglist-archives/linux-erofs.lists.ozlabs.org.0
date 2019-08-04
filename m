Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1DC80A70
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 12:34:15 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461chP1z0yzDqcc
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 20:34:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="gzNP+YVN"; 
 dkim-atps=neutral
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461chH32BTzDqcP
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Aug 2019 20:34:04 +1000 (AEST)
Received: by mail-ed1-x535.google.com with SMTP id v15so76175825eds.9
 for <linux-erofs@lists.ozlabs.org>; Sun, 04 Aug 2019 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S9kvxJmqqOakOY44UaVWdJhlYMM2omNdtJKg4yk/2Fc=;
 b=gzNP+YVNREYq/K+LLBXlVAMqTdEriI50OgY7kjFyNZsTzI9Tjv0odU4JGUIznMtuJA
 nRw+o5SrwZJjBtceyeVOQojyCnB3qfEAce4HYTx/n2gr4VqIzjHtnjqDUyLt28xtPkZj
 y1NqGvQkREEAQFAm8VTTC7q9Jl7e1kIJ+GCrhmH0N8i+byTdsCepmNUduChwklR8zrKH
 GzqTg29j4k/X54v8KHa/Pr14uZaXMPnF8e8LlAekE8VWJLWGpyLBNBRKo5CV+/alAphp
 QyPMz5vOrxAbiTcS9+IROxbp6RnE5c2X3hZtc2TUMvUu09F8XzR4GO9NsacV32YwjYUy
 KR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S9kvxJmqqOakOY44UaVWdJhlYMM2omNdtJKg4yk/2Fc=;
 b=cFT1RLYm5fy5x3pVclRSAyuqtGe9VApjYNs8IH7ODaDTRcwXpdNmbI78Ab5uKXqn7N
 QEvxKWuEBwycbIIPsQQa0mxw0Akcns4meO3TT6/SdBLzv6XjW5W3MNLq3pbgI5d2VGer
 KVN2zPoHMqtAkDf/Jkyqf3OfXpNBSQUGF4L9OfnzjUWvhV3ZxKSEe5MH0hDRgV5rL/Mk
 u/duQ+XFtTPWUxR62xjP0HrhUTJoyYUHK/ULzixToQUV73WP/EjCelZiaz6eQbO9RnPH
 4PM6ohTuiFClTAf4RGjW7s3oZoyKZOzkFNqj1sXNAA+Y5SYWjupxOiqzbQ6GMuqcQe+2
 fcZQ==
X-Gm-Message-State: APjAAAUHvZ1WT3PT/qA8AjnBr+fj7+4rXJ+RbsxGgYF83L6jfSG3Xyit
 Qe+V4Wb+waLov1tSxjm9pGdGbISPVH6mitiOHKQ=
X-Google-Smtp-Source: APXvYqy2l05YFadueA1QvppdAKfe4xGaxP3nWArs2WJPAgmuR3YREP4urbBxiAaICQ8gV+Lm/15ExpJ0tCPT8YJNixo=
X-Received: by 2002:aa7:c509:: with SMTP id o9mr91778587edq.164.1564914840271; 
 Sun, 04 Aug 2019 03:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190804081943.20666-1-pratikshinde320@gmail.com>
 <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190804101644.GA19667@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Sun, 4 Aug 2019 16:03:49 +0530
Message-ID: <CAGu0czRmt9X7yPmhj=7umo3wPoAt3Z_V2hYGV==kb2eohy2Skw@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: code for handling incorrect debug level.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="0000000000002880b9058f4821c2"
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000002880b9058f4821c2
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

I used fprintf here because we are printing this error message in case of
invalid 'cfg.c_dbg_lvl'. Hence I thought
we cannot rely on erofs_err().
e.g
$ mkfs.erofs -d -1 <erofs image> <directory>
In this case debug level is '-1' which is invalid.If we try to print the
error message using erofs_err() with c_dbg_lvl = -1,
it will not print anything.
While applying the minor fixup, just reset the c_dbg_lvl to 0 , so that
erofs_err() will be able to log the error message.

--Pratik.


On Sun, Aug 4, 2019 at 3:47 PM Gao Xiang <hsiangkao@aol.com> wrote:

> On Sun, Aug 04, 2019 at 01:49:43PM +0530, Pratik Shinde wrote:
> > handling the case of incorrect debug level.
> > Added an enumerated type for supported debug levels.
> > Using 'atoi' in place of 'parse_num_from_str'.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > ---
> >  include/erofs/print.h | 18 +++++++++++++-----
> >  mkfs/main.c           | 19 ++++++++-----------
> >  2 files changed, 21 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/erofs/print.h b/include/erofs/print.h
> > index bc0b8d4..296cbbf 100644
> > --- a/include/erofs/print.h
> > +++ b/include/erofs/print.h
> > @@ -12,6 +12,15 @@
> >  #include "config.h"
> >  #include <stdio.h>
> >
> > +enum {
> > +     EROFS_MSG_MIN = 0,
> > +     EROFS_ERR     = 0,
> > +     EROFS_WARN    = 2,
> > +     EROFS_INFO    = 3,
> > +     EROFS_DBG     = 7,
> > +     EROFS_MSG_MAX = 9
> > +};
> > +
> >  #define FUNC_LINE_FMT "%s() Line[%d] "
> >
> >  #ifndef pr_fmt
> > @@ -19,7 +28,7 @@
> >  #endif
> >
> >  #define erofs_dbg(fmt, ...) do {                             \
> > -     if (cfg.c_dbg_lvl >= 7) {                               \
> > +     if (cfg.c_dbg_lvl >= EROFS_DBG) {                       \
> >               fprintf(stdout,                                 \
> >                       pr_fmt(fmt),                            \
> >                       __func__,                               \
> > @@ -29,7 +38,7 @@
> >  } while (0)
> >
> >  #define erofs_info(fmt, ...) do {                            \
> > -     if (cfg.c_dbg_lvl >= 3) {                               \
> > +     if (cfg.c_dbg_lvl >= EROFS_INFO) {                      \
> >               fprintf(stdout,                                 \
> >                       pr_fmt(fmt),                            \
> >                       __func__,                               \
> > @@ -40,7 +49,7 @@
> >  } while (0)
> >
> >  #define erofs_warn(fmt, ...) do {                            \
> > -     if (cfg.c_dbg_lvl >= 2) {                               \
> > +     if (cfg.c_dbg_lvl >= EROFS_WARN) {                      \
> >               fprintf(stdout,                                 \
> >                       pr_fmt(fmt),                            \
> >                       __func__,                               \
> > @@ -51,7 +60,7 @@
> >  } while (0)
> >
> >  #define erofs_err(fmt, ...) do {                             \
> > -     if (cfg.c_dbg_lvl >= 0) {                               \
> > +     if (cfg.c_dbg_lvl >= EROFS_ERR) {                       \
> >               fprintf(stderr,                                 \
> >                       "Err: " pr_fmt(fmt),                    \
> >                       __func__,                               \
> > @@ -64,4 +73,3 @@
> >
> >
> >  #endif
> > -
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index fdb65fd..d915d00 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -30,16 +30,6 @@ static void usage(void)
> >       fprintf(stderr, " -EX[,...] X=extended options\n");
> >  }
> >
> > -u64 parse_num_from_str(const char *str)
> > -{
> > -     u64 num      = 0;
> > -     char *endptr = NULL;
> > -
> > -     num = strtoull(str, &endptr, 10);
> > -     BUG_ON(num == ULLONG_MAX);
> > -     return num;
> > -}
> > -
> >  static int parse_extended_opts(const char *opts)
> >  {
> >  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> > @@ -108,7 +98,14 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
> >                       break;
> >
> >               case 'd':
> > -                     cfg.c_dbg_lvl = parse_num_from_str(optarg);
> > +                     cfg.c_dbg_lvl = atoi(optarg);
> > +                     if (cfg.c_dbg_lvl < EROFS_MSG_MIN
> > +                         || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
> > +                             fprintf(stderr,
> > +                                     "invalid debug level %d\n",
> > +                                     cfg.c_dbg_lvl);
>
> How about using erofs_err as my previous patch attached?
> I wonder if there are some specfic reasons to directly use fprintf instead?
>
> I will apply it with this minor fixup (no need to resend again), if you
> have
> other considerations, reply me in this thread, thanks. :)
>
> Thanks,
> Gao Xiang
>
> > +                             return -EINVAL;
> > +                     }
> >                       break;
> >
> >               case 'E':
> > --
> > 2.9.3
> >
>

--0000000000002880b9058f4821c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBHYW8sPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIHVz
ZWQgZnByaW50ZiBoZXJlIGJlY2F1c2Ugd2UgYXJlIHByaW50aW5nIHRoaXMgZXJyb3IgbWVzc2Fn
ZSBpbiBjYXNlIG9mIGludmFsaWQgJiMzOTtjZmcuY19kYmdfbHZsJiMzOTsuIEhlbmNlIEkgdGhv
dWdodDwvZGl2PjxkaXY+d2UgY2Fubm90IHJlbHkgb24gZXJvZnNfZXJyKCkuPC9kaXY+PGRpdj5l
Lmc8L2Rpdj48ZGl2PiQgbWtmcy5lcm9mcyAtZCAtMSAmbHQ7ZXJvZnMgaW1hZ2UmZ3Q7ICZsdDtk
aXJlY3RvcnkmZ3Q7PC9kaXY+PGRpdj5JbiB0aGlzIGNhc2UgZGVidWcgbGV2ZWwgaXMgJiMzOTst
MSYjMzk7IHdoaWNoIGlzIGludmFsaWQuSWYgd2UgdHJ5IHRvIHByaW50IHRoZSBlcnJvciBtZXNz
YWdlIHVzaW5nIGVyb2ZzX2VycigpIHdpdGggDQpjX2RiZ19sdmwgPSAtMSw8L2Rpdj48ZGl2Pml0
IHdpbGwgbm90IHByaW50IGFueXRoaW5nLjwvZGl2PjxkaXY+V2hpbGUgYXBwbHlpbmcgdGhlIG1p
bm9yIGZpeHVwLCBqdXN0IHJlc2V0IHRoZSANCmNfZGJnX2x2bCB0byAwICwgc28gdGhhdCBlcm9m
c19lcnIoKSB3aWxsIGJlIGFibGUgdG8gbG9nIHRoZSBlcnJvciBtZXNzYWdlLjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+LS1QcmF0aWsuPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+
T24gU3VuLCBBdWcgNCwgMjAxOSBhdCAzOjQ3IFBNIEdhbyBYaWFuZyAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmhzaWFuZ2thb0Bhb2wuY29tIj5oc2lhbmdrYW9AYW9sLmNvbTwvYT4mZ3Q7IHdyb3RlOjxi
cj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFk
ZGluZy1sZWZ0OjFleCI+T24gU3VuLCBBdWcgMDQsIDIwMTkgYXQgMDE6NDk6NDNQTSArMDUzMCwg
UHJhdGlrIFNoaW5kZSB3cm90ZTo8YnI+DQomZ3Q7IGhhbmRsaW5nIHRoZSBjYXNlIG9mIGluY29y
cmVjdCBkZWJ1ZyBsZXZlbC48YnI+DQomZ3Q7IEFkZGVkIGFuIGVudW1lcmF0ZWQgdHlwZSBmb3Ig
c3VwcG9ydGVkIGRlYnVnIGxldmVscy48YnI+DQomZ3Q7IFVzaW5nICYjMzk7YXRvaSYjMzk7IGlu
IHBsYWNlIG9mICYjMzk7cGFyc2VfbnVtX2Zyb21fc3RyJiMzOTsuPGJyPg0KJmd0OyA8YnI+DQom
Z3Q7IFNpZ25lZC1vZmYtYnk6IFByYXRpayBTaGluZGUgJmx0OzxhIGhyZWY9Im1haWx0bzpwcmF0
aWtzaGluZGUzMjBAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+cHJhdGlrc2hpbmRlMzIwQGdt
YWlsLmNvbTwvYT4mZ3Q7PGJyPg0KJmd0OyAtLS08YnI+DQomZ3Q7wqAgaW5jbHVkZS9lcm9mcy9w
cmludC5oIHwgMTggKysrKysrKysrKysrKy0tLS0tPGJyPg0KJmd0O8KgIG1rZnMvbWFpbi5jwqAg
wqAgwqAgwqAgwqAgwqB8IDE5ICsrKysrKysrLS0tLS0tLS0tLS08YnI+DQomZ3Q7wqAgMiBmaWxl
cyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSk8YnI+DQomZ3Q7IDxi
cj4NCiZndDsgZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXJvZnMvcHJpbnQuaCBiL2luY2x1ZGUvZXJv
ZnMvcHJpbnQuaDxicj4NCiZndDsgaW5kZXggYmMwYjhkNC4uMjk2Y2JiZiAxMDA2NDQ8YnI+DQom
Z3Q7IC0tLSBhL2luY2x1ZGUvZXJvZnMvcHJpbnQuaDxicj4NCiZndDsgKysrIGIvaW5jbHVkZS9l
cm9mcy9wcmludC5oPGJyPg0KJmd0OyBAQCAtMTIsNiArMTIsMTUgQEA8YnI+DQomZ3Q7wqAgI2lu
Y2x1ZGUgJnF1b3Q7Y29uZmlnLmgmcXVvdDs8YnI+DQomZ3Q7wqAgI2luY2x1ZGUgJmx0O3N0ZGlv
LmgmZ3Q7PGJyPg0KJmd0O8KgIDxicj4NCiZndDsgK2VudW0gezxicj4NCiZndDsgK8KgIMKgIMKg
RVJPRlNfTVNHX01JTiA9IDAsPGJyPg0KJmd0OyArwqAgwqAgwqBFUk9GU19FUlLCoCDCoCDCoD0g
MCw8YnI+DQomZ3Q7ICvCoCDCoCDCoEVST0ZTX1dBUk7CoCDCoCA9IDIsPGJyPg0KJmd0OyArwqAg
wqAgwqBFUk9GU19JTkZPwqAgwqAgPSAzLDxicj4NCiZndDsgK8KgIMKgIMKgRVJPRlNfREJHwqAg
wqAgwqA9IDcsPGJyPg0KJmd0OyArwqAgwqAgwqBFUk9GU19NU0dfTUFYID0gOTxicj4NCiZndDsg
K307PGJyPg0KJmd0OyArPGJyPg0KJmd0O8KgICNkZWZpbmUgRlVOQ19MSU5FX0ZNVCAmcXVvdDsl
cygpIExpbmVbJWRdICZxdW90Ozxicj4NCiZndDvCoCA8YnI+DQomZ3Q7wqAgI2lmbmRlZiBwcl9m
bXQ8YnI+DQomZ3Q7IEBAIC0xOSw3ICsyOCw3IEBAPGJyPg0KJmd0O8KgICNlbmRpZjxicj4NCiZn
dDvCoCA8YnI+DQomZ3Q7wqAgI2RlZmluZSBlcm9mc19kYmcoZm10LCAuLi4pIGRvIHvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7IC3CoCDCoCDC
oGlmIChjZmcuY19kYmdfbHZsICZndDs9IDcpIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7ICvCoCDCoCDCoGlmIChjZmcuY19kYmdfbHZs
ICZndDs9IEVST0ZTX0RCRykge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoc3Rkb3V0LMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByX2ZtdChmbXQpLMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBfX2Z1bmNfXyzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7IEBAIC0yOSw3ICszOCw3IEBAPGJyPg0KJmd0O8KgIH0g
d2hpbGUgKDApPGJyPg0KJmd0O8KgIDxicj4NCiZndDvCoCAjZGVmaW5lIGVyb2ZzX2luZm8oZm10
LCAuLi4pIGRvIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJy
Pg0KJmd0OyAtwqAgwqAgwqBpZiAoY2ZnLmNfZGJnX2x2bCAmZ3Q7PSAzKSB7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0OyArwqAgwqAgwqBp
ZiAoY2ZnLmNfZGJnX2x2bCAmZ3Q7PSBFUk9GU19JTkZPKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoc3Rk
b3V0LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHByX2ZtdChmbXQpLMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8YnI+DQomZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX2Z1bmNfXyzCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7IEBAIC00MCw3ICs0OSw3IEBA
PGJyPg0KJmd0O8KgIH0gd2hpbGUgKDApPGJyPg0KJmd0O8KgIDxicj4NCiZndDvCoCAjZGVmaW5l
IGVyb2ZzX3dhcm4oZm10LCAuLi4pIGRvIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBcPGJyPg0KJmd0OyAtwqAgwqAgwqBpZiAoY2ZnLmNfZGJnX2x2bCAmZ3Q7PSAy
KSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0K
Jmd0OyArwqAgwqAgwqBpZiAoY2ZnLmNfZGJnX2x2bCAmZ3Q7PSBFUk9GU19XQVJOKSB7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGZwcmludGYoc3Rkb3V0LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgXDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHByX2ZtdChmbXQpLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX2Z1bmNfXyzCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQomZ3Q7IEBA
IC01MSw3ICs2MCw3IEBAPGJyPg0KJmd0O8KgIH0gd2hpbGUgKDApPGJyPg0KJmd0O8KgIDxicj4N
CiZndDvCoCAjZGVmaW5lIGVyb2ZzX2VycihmbXQsIC4uLikgZG8ge8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCiZndDsgLcKgIMKgIMKgaWYgKGNmZy5j
X2RiZ19sdmwgJmd0Oz0gMCkge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgXDxicj4NCiZndDsgK8KgIMKgIMKgaWYgKGNmZy5jX2RiZ19sdmwgJmd0Oz0gRVJP
RlNfRVJSKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihzdGRlcnIswqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7RXJyOiAmcXVvdDsgcHJfZm10KGZtdCkswqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoF9fZnVuY19fLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgXDxicj4NCiZndDsgQEAgLTY0LDQgKzczLDMgQEA8YnI+DQomZ3Q7wqAgPGJyPg0K
Jmd0O8KgIDxicj4NCiZndDvCoCAjZW5kaWY8YnI+DQomZ3Q7IC08YnI+DQomZ3Q7IGRpZmYgLS1n
aXQgYS9ta2ZzL21haW4uYyBiL21rZnMvbWFpbi5jPGJyPg0KJmd0OyBpbmRleCBmZGI2NWZkLi5k
OTE1ZDAwIDEwMDY0NDxicj4NCiZndDsgLS0tIGEvbWtmcy9tYWluLmM8YnI+DQomZ3Q7ICsrKyBi
L21rZnMvbWFpbi5jPGJyPg0KJmd0OyBAQCAtMzAsMTYgKzMwLDYgQEAgc3RhdGljIHZvaWQgdXNh
Z2Uodm9pZCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciwgJnF1b3Q7IC1FWFss
Li4uXSBYPWV4dGVuZGVkIG9wdGlvbnNcbiZxdW90Oyk7PGJyPg0KJmd0O8KgIH08YnI+DQomZ3Q7
wqAgPGJyPg0KJmd0OyAtdTY0IHBhcnNlX251bV9mcm9tX3N0cihjb25zdCBjaGFyICpzdHIpPGJy
Pg0KJmd0OyAtezxicj4NCiZndDsgLcKgIMKgIMKgdTY0IG51bcKgIMKgIMKgID0gMDs8YnI+DQom
Z3Q7IC3CoCDCoCDCoGNoYXIgKmVuZHB0ciA9IE5VTEw7PGJyPg0KJmd0OyAtPGJyPg0KJmd0OyAt
wqAgwqAgwqBudW0gPSBzdHJ0b3VsbChzdHIsICZhbXA7ZW5kcHRyLCAxMCk7PGJyPg0KJmd0OyAt
wqAgwqAgwqBCVUdfT04obnVtID09IFVMTE9OR19NQVgpOzxicj4NCiZndDsgLcKgIMKgIMKgcmV0
dXJuIG51bTs8YnI+DQomZ3Q7IC19PGJyPg0KJmd0OyAtPGJyPg0KJmd0O8KgIHN0YXRpYyBpbnQg
cGFyc2VfZXh0ZW5kZWRfb3B0cyhjb25zdCBjaGFyICpvcHRzKTxicj4NCiZndDvCoCB7PGJyPg0K
Jmd0O8KgICNkZWZpbmUgTUFUQ0hfRVhURU5URURfT1BUKG9wdCwgdG9rZW4sIGtleWxlbikgXDxi
cj4NCiZndDsgQEAgLTEwOCw3ICs5OCwxNCBAQCBzdGF0aWMgaW50IG1rZnNfcGFyc2Vfb3B0aW9u
c19jZmcoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQomZ3Q7wqAgPGJyPg0KJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY2FzZSAmIzM5O2QmIzM5Ozo8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNmZy5jX2RiZ19sdmwgPSBwYXJzZV9udW1fZnJvbV9zdHIob3B0YXJn
KTs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNmZy5jX2RiZ19s
dmwgPSBhdG9pKG9wdGFyZyk7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAoY2ZnLmNfZGJnX2x2bCAmbHQ7IEVST0ZTX01TR19NSU48YnI+DQomZ3Q7ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHx8IGNmZy5jX2RiZ19sdmwgJmd0OyBF
Uk9GU19NU0dfTUFYKSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBmcHJpbnRmKHN0ZGVyciw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O2ludmFsaWQgZGVi
dWcgbGV2ZWwgJWRcbiZxdW90Oyw8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNmZy5jX2RiZ19sdmwpOzxicj4NCjxicj4N
CkhvdyBhYm91dCB1c2luZyBlcm9mc19lcnIgYXMgbXkgcHJldmlvdXMgcGF0Y2ggYXR0YWNoZWQ/
PGJyPg0KSSB3b25kZXIgaWYgdGhlcmUgYXJlIHNvbWUgc3BlY2ZpYyByZWFzb25zIHRvIGRpcmVj
dGx5IHVzZSBmcHJpbnRmIGluc3RlYWQ/PGJyPg0KPGJyPg0KSSB3aWxsIGFwcGx5IGl0IHdpdGgg
dGhpcyBtaW5vciBmaXh1cCAobm8gbmVlZCB0byByZXNlbmQgYWdhaW4pLCBpZiB5b3UgaGF2ZTxi
cj4NCm90aGVyIGNvbnNpZGVyYXRpb25zLCByZXBseSBtZSBpbiB0aGlzIHRocmVhZCwgdGhhbmtz
LiA6KTxicj4NCjxicj4NClRoYW5rcyw8YnI+DQpHYW8gWGlhbmc8YnI+DQo8YnI+DQomZ3Q7ICvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiAtRUlOVkFM
Ozxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCiZndDvCoCA8YnI+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlICYjMzk7RSYjMzk7Ojxicj4NCiZndDsg
LS0gPGJyPg0KJmd0OyAyLjkuMzxicj4NCiZndDsgPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2Pg0K
--0000000000002880b9058f4821c2--
