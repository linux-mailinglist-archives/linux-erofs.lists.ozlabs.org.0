Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26D8809D5
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 09:41:55 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 461XsX3fHgzDqrC
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Aug 2019 17:41:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=pratikshinde320@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="P1akP6z3"; 
 dkim-atps=neutral
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461XsQ5JlczDqdx
 for <linux-erofs@lists.ozlabs.org>; Sun,  4 Aug 2019 17:41:43 +1000 (AEST)
Received: by mail-ed1-x52f.google.com with SMTP id k21so75988475edq.3
 for <linux-erofs@lists.ozlabs.org>; Sun, 04 Aug 2019 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9kWxbdLu+GpHWnyDtyK2qidKiF2hAdtZwLZrUmXsXeY=;
 b=P1akP6z3GtabnRufFnPNJMc2wJpM3oLGhDy23q38SczMZjQR4z4+x1YaqiWNubf4SX
 youYqBTUs2rkEOhjJM6eO247nJTO/B2bK+8lKcVDwcPaR0o3IhCb42LrA03hxHVNAyTq
 R/vmjC6dUQA30IXlS07iDIzjwmQ8POigaN6MUUpAdoxrHE+4GnUK5ln79sRBqbR7MZ+t
 fKhqhEVwJbmdXjT6grxw7Xika2Y4LFX8//6EAMX72cXKJVZsmLny7Tpa/a2dJkSkTtO5
 HAgXSnbG/d/Ky4QYjxYhHFJc+wFZI6wUFFSb8RtwbfBun1qzAH5gTEpDNkBhjiZpl8D4
 N2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9kWxbdLu+GpHWnyDtyK2qidKiF2hAdtZwLZrUmXsXeY=;
 b=qXIoM2o8zOzMqBv/h0xXga8pgb/siW3kM8EvER2R/K8vb7ZDmq7+IC2ZITq3hkBVvv
 i+S3f24oDPQjhL3xjeAsiG8fQIPG+iJeZ/QrXpRrYwkvb1VoNnulW54BUEdkZTJdywMp
 F3PMJv9MZaRc6fLWXmjRyj2Z9VHCP5SNDlrG2RwqrVh53Tb96X8wTZoUb6PsdVOp0yX7
 NxoGDamq4DVBwHaOt/IrVs1VoWGUXxKik7ExMAjzS0eKkd8G9KrUy8rrK1x6Wc5sTnSH
 VbFtQp39k2qIaWnXCUTqp/m7xYglGtIL/xQQ4aAwTiQNyxgEhHc7bUEsQhXZetxeHKWa
 UaeA==
X-Gm-Message-State: APjAAAVPfFrUZPlU7tnp6BzVAqBwi8cZ78lwn+mYIO6z0VEXKzsATIdw
 Y11pqrZnA04hca3PJlQjInH0WSrBv3i6TMVSjms=
X-Google-Smtp-Source: APXvYqz7jFW5ZDe1y1QnEfY4AdD5PG66gEBzC3nZFGId3LmwdK0YjUAbusgA7uayQCvEujSqy4Kxq31y2iChWiCrM6A=
X-Received: by 2002:a17:906:1594:: with SMTP id
 k20mr8150169ejd.49.1564904498606; 
 Sun, 04 Aug 2019 00:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190803080310.17827-1-pratikshinde320@gmail.com>
 <20190804040952.GA32699@hsiangkao-HP-ZHAN-66-Pro-G1>
In-Reply-To: <20190804040952.GA32699@hsiangkao-HP-ZHAN-66-Pro-G1>
From: Pratik Shinde <pratikshinde320@gmail.com>
Date: Sun, 4 Aug 2019 13:11:27 +0530
Message-ID: <CAGu0czSaBFgZykK2Uh7jk0iWTevA9mGqeLe1ayLmaqaTWtzs=g@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: code for handling incorrect debug level.
To: Gao Xiang <hsiangkao@aol.com>
Content-Type: multipart/alternative; boundary="000000000000bf3651058f45b8cd"
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

--000000000000bf3651058f45b8cd
Content-Type: text/plain; charset="UTF-8"

Hi Gao,

Yes, I will include those changes and resend the patch.

--Pratik.

On Sun, Aug 4, 2019 at 9:40 AM Gao Xiang <hsiangkao@aol.com> wrote:

> Hi Pratik,
>
> On Sat, Aug 03, 2019 at 01:33:10PM +0530, Pratik Shinde wrote:
> > handling the case of incorrect debug level.
> > Added an enumerated type for supported debug levels.
> > Using 'atoi' in place of 'parse_num_from_str'.
> >
> > I have dropped the check for invalid compression algo name(which was
> there
> > in last patch)
> > Note:I think this patch covers different set of code changes than
> previous
> > patch,Hence I am sending a new patch instead of 'v2' of previous patch.
> >
> > Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
>
> It looks good to me, and I'd like to introduce "EROFS_MSG_MIN /
> EROFS_MSG_MAX" as well.
> Do you agree with these modifications attached below? :)
>
> Thanks,
> Gao Xiang
>
> diff --git a/include/erofs/print.h b/include/erofs/print.h
> index bc0b8d4..e29fc1d 100644
> --- a/include/erofs/print.h
> +++ b/include/erofs/print.h
> @@ -12,6 +12,15 @@
>  #include "config.h"
>  #include <stdio.h>
>
> +enum {
> +       EROFS_MSG_MIN = 0,
> +       EROFS_ERR     = 0,
> +       EROFS_WARN    = 2,
> +       EROFS_INFO    = 3,
> +       EROFS_DBG     = 7,
> +       EROFS_MSG_MAX = 9
> +};
> +
>  #define FUNC_LINE_FMT "%s() Line[%d] "
>
>  #ifndef pr_fmt
> @@ -19,7 +28,7 @@
>  #endif
>
>  #define erofs_dbg(fmt, ...) do {                               \
> -       if (cfg.c_dbg_lvl >= 7) {                               \
> +       if (cfg.c_dbg_lvl >= EROFS_DBG) {                       \
>                 fprintf(stdout,                                 \
>                         pr_fmt(fmt),                            \
>                         __func__,                               \
> @@ -29,7 +38,7 @@
>  } while (0)
>
>  #define erofs_info(fmt, ...) do {                              \
> -       if (cfg.c_dbg_lvl >= 3) {                               \
> +       if (cfg.c_dbg_lvl >= EROFS_INFO) {                      \
>                 fprintf(stdout,                                 \
>                         pr_fmt(fmt),                            \
>                         __func__,                               \
> @@ -40,7 +49,7 @@
>  } while (0)
>
>  #define erofs_warn(fmt, ...) do {                              \
> -       if (cfg.c_dbg_lvl >= 2) {                               \
> +       if (cfg.c_dbg_lvl >= EROFS_WARN) {                      \
>                 fprintf(stdout,                                 \
>                         pr_fmt(fmt),                            \
>                         __func__,                               \
> @@ -51,7 +60,7 @@
>  } while (0)
>
>  #define erofs_err(fmt, ...) do {                               \
> -       if (cfg.c_dbg_lvl >= 0) {                               \
> +       if (cfg.c_dbg_lvl >= EROFS_ERR) {                       \
>                 fprintf(stderr,                                 \
>                         "Err: " pr_fmt(fmt),                    \
>                         __func__,                               \
> diff --git a/mkfs/main.c b/mkfs/main.c
> index fdb65fd..33b0db5 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -30,16 +30,6 @@ static void usage(void)
>         fprintf(stderr, " -EX[,...] X=extended options\n");
>  }
>
> -u64 parse_num_from_str(const char *str)
> -{
> -       u64 num      = 0;
> -       char *endptr = NULL;
> -
> -       num = strtoull(str, &endptr, 10);
> -       BUG_ON(num == ULLONG_MAX);
> -       return num;
> -}
> -
>  static int parse_extended_opts(const char *opts)
>  {
>  #define MATCH_EXTENTED_OPT(opt, token, keylen) \
> @@ -108,7 +98,13 @@ static int mkfs_parse_options_cfg(int argc, char
> *argv[])
>                         break;
>
>                 case 'd':
> -                       cfg.c_dbg_lvl = parse_num_from_str(optarg);
> +                       cfg.c_dbg_lvl = atoi(optarg);
> +                       if (cfg.c_dbg_lvl < EROFS_MSG_MIN
> +                           || cfg.c_dbg_lvl > EROFS_MSG_MAX) {
> +                               erofs_err("invalid debug level %d",
> +                                         cfg.c_dbg_lvl);
> +                               return -EINVAL;
> +                       }
>                         break;
>
>                 case 'E':
> --
> 2.17.1
>
>

--000000000000bf3651058f45b8cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBHYW8sPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5ZZXMs
IEkgd2lsbCBpbmNsdWRlIHRob3NlIGNoYW5nZXMgYW5kIHJlc2VuZCB0aGUgcGF0Y2guPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj4tLVByYXRpay48YnI+PC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gU3Vu
LCBBdWcgNCwgMjAxOSBhdCA5OjQwIEFNIEdhbyBYaWFuZyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmhz
aWFuZ2thb0Bhb2wuY29tIj5oc2lhbmdrYW9AYW9sLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rp
dj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAw
cHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1s
ZWZ0OjFleCI+SGkgUHJhdGlrLDxicj4NCjxicj4NCk9uIFNhdCwgQXVnIDAzLCAyMDE5IGF0IDAx
OjMzOjEwUE0gKzA1MzAsIFByYXRpayBTaGluZGUgd3JvdGU6PGJyPg0KJmd0OyBoYW5kbGluZyB0
aGUgY2FzZSBvZiBpbmNvcnJlY3QgZGVidWcgbGV2ZWwuPGJyPg0KJmd0OyBBZGRlZCBhbiBlbnVt
ZXJhdGVkIHR5cGUgZm9yIHN1cHBvcnRlZCBkZWJ1ZyBsZXZlbHMuPGJyPg0KJmd0OyBVc2luZyAm
IzM5O2F0b2kmIzM5OyBpbiBwbGFjZSBvZiAmIzM5O3BhcnNlX251bV9mcm9tX3N0ciYjMzk7Ljxi
cj4NCiZndDsgPGJyPg0KJmd0OyBJIGhhdmUgZHJvcHBlZCB0aGUgY2hlY2sgZm9yIGludmFsaWQg
Y29tcHJlc3Npb24gYWxnbyBuYW1lKHdoaWNoIHdhcyB0aGVyZTxicj4NCiZndDsgaW4gbGFzdCBw
YXRjaCk8YnI+DQomZ3Q7IE5vdGU6SSB0aGluayB0aGlzIHBhdGNoIGNvdmVycyBkaWZmZXJlbnQg
c2V0IG9mIGNvZGUgY2hhbmdlcyB0aGFuIHByZXZpb3VzPGJyPg0KJmd0OyBwYXRjaCxIZW5jZSBJ
IGFtIHNlbmRpbmcgYSBuZXcgcGF0Y2ggaW5zdGVhZCBvZiAmIzM5O3YyJiMzOTsgb2YgcHJldmlv
dXMgcGF0Y2guPGJyPg0KJmd0OyA8YnI+DQomZ3Q7IFNpZ25lZC1vZmYtYnk6IFByYXRpayBTaGlu
ZGUgJmx0OzxhIGhyZWY9Im1haWx0bzpwcmF0aWtzaGluZGUzMjBAZ21haWwuY29tIiB0YXJnZXQ9
Il9ibGFuayI+cHJhdGlrc2hpbmRlMzIwQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPg0KPGJyPg0KSXQg
bG9va3MgZ29vZCB0byBtZSwgYW5kIEkmIzM5O2QgbGlrZSB0byBpbnRyb2R1Y2UgJnF1b3Q7RVJP
RlNfTVNHX01JTiAvIEVST0ZTX01TR19NQVgmcXVvdDsgYXMgd2VsbC48YnI+DQpEbyB5b3UgYWdy
ZWUgd2l0aCB0aGVzZSBtb2RpZmljYXRpb25zIGF0dGFjaGVkIGJlbG93PyA6KTxicj4NCjxicj4N
ClRoYW5rcyw8YnI+DQpHYW8gWGlhbmc8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9l
cm9mcy9wcmludC5oIGIvaW5jbHVkZS9lcm9mcy9wcmludC5oPGJyPg0KaW5kZXggYmMwYjhkNC4u
ZTI5ZmMxZCAxMDA2NDQ8YnI+DQotLS0gYS9pbmNsdWRlL2Vyb2ZzL3ByaW50Lmg8YnI+DQorKysg
Yi9pbmNsdWRlL2Vyb2ZzL3ByaW50Lmg8YnI+DQpAQCAtMTIsNiArMTIsMTUgQEA8YnI+DQrCoCNp
bmNsdWRlICZxdW90O2NvbmZpZy5oJnF1b3Q7PGJyPg0KwqAjaW5jbHVkZSAmbHQ7c3RkaW8uaCZn
dDs8YnI+DQo8YnI+DQorZW51bSB7PGJyPg0KK8KgIMKgIMKgIMKgRVJPRlNfTVNHX01JTiA9IDAs
PGJyPg0KK8KgIMKgIMKgIMKgRVJPRlNfRVJSwqAgwqAgwqA9IDAsPGJyPg0KK8KgIMKgIMKgIMKg
RVJPRlNfV0FSTsKgIMKgID0gMiw8YnI+DQorwqAgwqAgwqAgwqBFUk9GU19JTkZPwqAgwqAgPSAz
LDxicj4NCivCoCDCoCDCoCDCoEVST0ZTX0RCR8KgIMKgIMKgPSA3LDxicj4NCivCoCDCoCDCoCDC
oEVST0ZTX01TR19NQVggPSA5PGJyPg0KK307PGJyPg0KKzxicj4NCsKgI2RlZmluZSBGVU5DX0xJ
TkVfRk1UICZxdW90OyVzKCkgTGluZVslZF0gJnF1b3Q7PGJyPg0KPGJyPg0KwqAjaWZuZGVmIHBy
X2ZtdDxicj4NCkBAIC0xOSw3ICsyOCw3IEBAPGJyPg0KwqAjZW5kaWY8YnI+DQo8YnI+DQrCoCNk
ZWZpbmUgZXJvZnNfZGJnKGZtdCwgLi4uKSBkbyB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KLcKgIMKgIMKgIMKgaWYgKGNmZy5jX2RiZ19sdmwg
Jmd0Oz0gNykge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
XDxicj4NCivCoCDCoCDCoCDCoGlmIChjZmcuY19kYmdfbHZsICZndDs9IEVST0ZTX0RCRykge8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGZwcmludGYoc3Rkb3V0LMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHByX2ZtdChmbXQpLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX2Z1bmNfXyzCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQpAQCAtMjksNyAr
MzgsNyBAQDxicj4NCsKgfSB3aGlsZSAoMCk8YnI+DQo8YnI+DQrCoCNkZWZpbmUgZXJvZnNfaW5m
byhmbXQsIC4uLikgZG8ge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIFw8YnI+DQotwqAgwqAgwqAgwqBpZiAoY2ZnLmNfZGJnX2x2bCAmZ3Q7PSAzKSB7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKg
IMKgaWYgKGNmZy5jX2RiZ19sdmwgJmd0Oz0gRVJPRlNfSU5GTykge8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKHN0
ZG91dCzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcl9mbXQoZm10KSzCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19mdW5jX18swqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KQEAgLTQwLDcgKzQ5LDcgQEA8YnI+DQrCoH0g
d2hpbGUgKDApPGJyPg0KPGJyPg0KwqAjZGVmaW5lIGVyb2ZzX3dhcm4oZm10LCAuLi4pIGRvIHvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBcPGJyPg0KLcKgIMKg
IMKgIMKgaWYgKGNmZy5jX2RiZ19sdmwgJmd0Oz0gMikge8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxicj4NCivCoCDCoCDCoCDCoGlmIChjZmcuY19kYmdf
bHZsICZndDs9IEVST0ZTX1dBUk4pIHvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBc
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihzdGRvdXQswqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHJfZm10KGZtdCkswqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIF9fZnVuY19fLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgXDxicj4NCkBAIC01MSw3ICs2MCw3IEBAPGJyPg0KwqB9IHdoaWxlICgwKTxicj4NCjxi
cj4NCsKgI2RlZmluZSBlcm9mc19lcnIoZm10LCAuLi4pIGRvIHvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFw8YnI+DQotwqAgwqAgwqAgwqBpZiAoY2ZnLmNf
ZGJnX2x2bCAmZ3Q7PSAwKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBcPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGNmZy5jX2RiZ19sdmwgJmd0Oz0gRVJPRlNf
RVJSKSB7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZnByaW50ZihzdGRlcnIswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgJnF1b3Q7RXJyOiAmcXVvdDsgcHJfZm10KGZtdCkswqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9f
ZnVuY19fLMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXDxi
cj4NCmRpZmYgLS1naXQgYS9ta2ZzL21haW4uYyBiL21rZnMvbWFpbi5jPGJyPg0KaW5kZXggZmRi
NjVmZC4uMzNiMGRiNSAxMDA2NDQ8YnI+DQotLS0gYS9ta2ZzL21haW4uYzxicj4NCisrKyBiL21r
ZnMvbWFpbi5jPGJyPg0KQEAgLTMwLDE2ICszMCw2IEBAIHN0YXRpYyB2b2lkIHVzYWdlKHZvaWQp
PGJyPg0KwqAgwqAgwqAgwqAgZnByaW50ZihzdGRlcnIsICZxdW90OyAtRVhbLC4uLl0gWD1leHRl
bmRlZCBvcHRpb25zXG4mcXVvdDspOzxicj4NCsKgfTxicj4NCjxicj4NCi11NjQgcGFyc2VfbnVt
X2Zyb21fc3RyKGNvbnN0IGNoYXIgKnN0cik8YnI+DQotezxicj4NCi3CoCDCoCDCoCDCoHU2NCBu
dW3CoCDCoCDCoCA9IDA7PGJyPg0KLcKgIMKgIMKgIMKgY2hhciAqZW5kcHRyID0gTlVMTDs8YnI+
DQotPGJyPg0KLcKgIMKgIMKgIMKgbnVtID0gc3RydG91bGwoc3RyLCAmYW1wO2VuZHB0ciwgMTAp
Ozxicj4NCi3CoCDCoCDCoCDCoEJVR19PTihudW0gPT0gVUxMT05HX01BWCk7PGJyPg0KLcKgIMKg
IMKgIMKgcmV0dXJuIG51bTs8YnI+DQotfTxicj4NCi08YnI+DQrCoHN0YXRpYyBpbnQgcGFyc2Vf
ZXh0ZW5kZWRfb3B0cyhjb25zdCBjaGFyICpvcHRzKTxicj4NCsKgezxicj4NCsKgI2RlZmluZSBN
QVRDSF9FWFRFTlRFRF9PUFQob3B0LCB0b2tlbiwga2V5bGVuKSBcPGJyPg0KQEAgLTEwOCw3ICs5
OCwxMyBAQCBzdGF0aWMgaW50IG1rZnNfcGFyc2Vfb3B0aW9uc19jZmcoaW50IGFyZ2MsIGNoYXIg
KmFyZ3ZbXSk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazs8
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYXNlICYjMzk7ZCYjMzk7Ojxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNmZy5jX2RiZ19sdmwgPSBwYXJz
ZV9udW1fZnJvbV9zdHIob3B0YXJnKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjZmcuY19kYmdfbHZsID0gYXRvaShvcHRhcmcpOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChjZmcuY19kYmdfbHZsICZsdDsgRVJPRlNfTVNHX01J
Tjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHx8IGNmZy5j
X2RiZ19sdmwgJmd0OyBFUk9GU19NU0dfTUFYKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZXJvZnNfZXJyKCZxdW90O2ludmFsaWQgZGVidWcg
bGV2ZWwgJWQmcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2ZnLmNfZGJnX2x2bCk7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU5WQUw7PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJyZWFrOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGNhc2UgJiMzOTtFJiMzOTs6PGJyPg0KLS0gPGJyPg0KMi4xNy4xPGJyPg0KPGJy
Pg0KPC9ibG9ja3F1b3RlPjwvZGl2Pg0K
--000000000000bf3651058f45b8cd--
