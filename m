Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C248F96CED0
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 07:58:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725515902;
	bh=Q+MRlYQUwQAqK4FKE1BQD66tfjwi/zOiI/ollrDGUAI=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ui9s0M3miumWtlxgEi2pbyaYXgrts8iq/ymsLbW4QSoOrL0pj1GNV+BoSKiSsrCgP
	 MB+INcUfCNQSv5E2yzbYxUh189RRbebj/mBIYEnTtTZ+Hur12k4AmJ+zo6b2GLPKm7
	 OuQqKkQlZcixDL/PtNi38HswQSW/K8r2FmzD2Gh/lH/f9NBEexgVxlMmF9u35mGGkd
	 KeIgqHSbVfWdLJW7F5G043iuFoPvU/0E/FQstOy9reGDun56PvfZSCHHvxBDlR8l8C
	 tAdxzIKiPIMVCKiJElE606AgUXaSx8N+XttOkQHqbUYqjETvI6J8sW9POsgt3V4MF3
	 j1ZTOO873EduQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WzpZ64qBkz2ysf
	for <lists+linux-erofs@lfdr.de>; Thu,  5 Sep 2024 15:58:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725515900;
	cv=none; b=T96wlaPQdmKbeMOa3KwM9jazxooo9hbvpru2RS/x3ntjeqQZk5rttBT+B5UPPx6m62KfkzLjFoNXVI1sShwYVMipIjxeH9adXXKQRkwP1JKISXYoPzRLnzq3SVjYV1rq08bUjsS3VGlqEiKXRzbVaxecP3zL3hLOVEneHXcyqlr0QrFxSxROBcIScDdtovkzBLHXSXHt8hqrvmzhnT4aUjZSG8YvcLR4IfGj4gLFHRueXji0XjDC6nhuirJ7cjz6A5O5Rb5RjeUm1M/twDwOCJpDMGJCH7rEh9Dv9H0HprZKMBc/uBYEY2ub8+noEhy6XKyLqThQ/FsWNYn7h7MiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725515900; c=relaxed/relaxed;
	bh=Q+MRlYQUwQAqK4FKE1BQD66tfjwi/zOiI/ollrDGUAI=;
	h=DKIM-Signature:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type; b=kunzZy7rJuL59LwQrnRr4fUW5EXcYttN8QeKJH2X1JIZINfC2lplWtmWeOAeZBD7CXlh799uuHS/xEkPo7soob3r+kEi8jRO1JQLpso4BNXtHj++NrrIXsKiYp918KndsriNQ3eP0uaUFIB4Q4Gu9I6mEed0Wg5lMfrp+6NTJRh7ZhuZ7ZvAJnFxrE3TVn3TLNCdntON+s0PQYbKOP/p6+9JAhy2oq5WeAjEW6jexdk99j38jbV6cW2ZzdDYqM2VnMnLvnc7zGREQhluwlS0p2tk/0ska1SXxcaa0QVKt/OlJu5U32cqeAFkRn7dzDFEQrPk1gON9g/62aGM/OmLfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=wKA4S88J; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=wKA4S88J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WzpZ32yslz2xr2
	for <linux-erofs@lists.ozlabs.org>; Thu,  5 Sep 2024 15:58:18 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2055136b612so4302935ad.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 04 Sep 2024 22:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725515896; x=1726120696; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+MRlYQUwQAqK4FKE1BQD66tfjwi/zOiI/ollrDGUAI=;
        b=wKA4S88JeFByJeAxwADIBdwIaQ3rRC5i/aqSsmwe/h9ke2S0pZmaCpa+UOlLjnSdkE
         CnYXtKOffNdjI6SK27d2Q+J7oF5KKFEai0G3ixa0K/pjaAKB+7L/KmTmTnN6pp4hjdFY
         niUEiw0rFkhN1+iMGsID4PUnwv6IH3AVyDN6vg4qAi3NDMjoIy8UIXP7bDfCl6eACrX7
         JSntwTZVAOIW5iys6ARW+SNlStBr3aszw37rGijyWGclwlNwKccjs0sJiejMWSmRjsXY
         PQo3NDC2bt3dTOZwjWb0Onf6OlKCQxKgig+RihuVLxikRMfW4Q3kS4tMQyVH0NY9ABqw
         c5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725515896; x=1726120696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+MRlYQUwQAqK4FKE1BQD66tfjwi/zOiI/ollrDGUAI=;
        b=kQY8PgQDzdYFgyoTpveM095Bst+XwIekYB3JpcRugUjvQaw5QYPN0GowzWn7n10Njl
         43dCP4/b9C8DEJXe3M42mNAvBy4in/TqPvqXLhdqLzvuL3pYhxvbE9QHW9z0wbo+Remb
         wIkc7Bp0vVRWgAUGLrQBFQ56s7fMacbbDH8ecs0pzTLMk87CQlEgK5xMhTk0sdheNa02
         8wpulCH38PZ3dkM/OKGi83qQFndYg93qzj4UnTZEni8/mhxxxNTK/X1YzEM0IoqMuYzh
         k9xWY146K3wfukYvlJMFc8ekD3xrvELw+Wl7Dgkq6LyzP7Bx+cw5MScRD8kUEoxfTqD+
         Cikw==
X-Forwarded-Encrypted: i=1; AJvYcCXNpHCamcSac8ESQKbHM/ddPhzwBHzFD2SSVidJ6oWVTU4U6QtS2ebTxlQ3sJ86bcMfQgyN689Zc8yFyA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxK5sEXLi1htq44HDCZ3PyTfzq1M8lg7ml7AcDq4kEs7TiLdDuq
	HtliLBTTwpLE3mnDolk6CJIake4DWa3b1WR5Q68oDrrq0fFbq4F/1/6keC3cl09Z1DNlOIYsAIf
	zq6zgiiLLytpHFrSVQBn1imrl6HY0pDpu1Ub1
X-Google-Smtp-Source: AGHT+IESgMNF110E9bgti4QzVou/3B0nugqWLMHAX1KWGsNC57+nYovMVoggLSErx8riGf+H+FAbqG1FN0ds+iGVmVY=
X-Received: by 2002:a17:903:2303:b0:202:100f:7b99 with SMTP id
 d9443c01a7336-20546132a1emr196225355ad.22.1725515896026; Wed, 04 Sep 2024
 22:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240829122342.309611-1-jinbaoliu365@gmail.com>
 <CAB=BE-QfSB_BZNA_ZPt6G6WTbruHs8QtN9guGfZTkyjGjJNy5Q@mail.gmail.com>
 <7e1b1c15-dd7c-4565-a1dc-ba6a49cf249f@linux.alibaba.com> <5e9801aa-5655-4762-b0f7-538dad273f16@linux.alibaba.com>
In-Reply-To: <5e9801aa-5655-4762-b0f7-538dad273f16@linux.alibaba.com>
Date: Wed, 4 Sep 2024 22:58:04 -0700
Message-ID: <CAB=BE-THq7w1bhyZN=R0eefLWS_3qSeVU2ejz8hjbWpM5qxrEQ@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: Prevent entering an infinite loop when i is 0
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: liujinbao1 <jinbaoliu365@gmail.com>, mazhenhua@xiaomi.com, linux-erofs@lists.ozlabs.org, liujinbao1 <liujinbao1@xiaomi.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Sep 4, 2024 at 7:56=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> On 2024/8/31 10:58, Gao Xiang wrote:
> > Hi Sandeep,
> >
> > On 2024/8/31 05:46, Sandeep Dhavale wrote:
> >> Hi Liujinbao,
> >> On Thu, Aug 29, 2024 at 5:24=E2=80=AFAM liujinbao1 <jinbaoliu365@gmail=
.com> wrote:
> >>>
> >>> From: liujinbao1 <liujinbao1@xiaomi.com>
> >>>
> >>> When i=3D0 and err is not equal to 0,
> >>> the while(-1) loop will enter into an
> >>> infinite loop. This patch avoids this issue
> >>>
> >>> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
> >>> ---
> >>>   fs/erofs/decompressor.c | 10 +++++-----
> >>>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> >>> index c2253b6a5416..672f097966fa 100644
> >>> --- a/fs/erofs/decompressor.c
> >>> +++ b/fs/erofs/decompressor.c
> >>> @@ -534,18 +534,18 @@ int z_erofs_parse_cfgs(struct super_block *sb, =
struct erofs_super_block *dsb)
> >>>
> >>>   int __init z_erofs_init_decompressor(void)
> >>>   {
> >>> -       int i, err;
> >>> +       int i, err =3D 0;
> >>>
> >>>          for (i =3D 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
> >>>                  err =3D z_erofs_decomp[i] ? z_erofs_decomp[i]->init(=
) : 0;
> >>> -               if (err) {
> >>> -                       while (--i)
> >>> +               if (err && i) {
> >>> +                       while (i--)
> >> Actually there is a subtle bug in this fix. We will never enter the if
> >> block here when i=3D0 and err is set which we were trying to fix.
> >> This will cause z_erofs_decomp[0]->init() error to get masked and we
> >> will continue the outer for loop (i.e. when i=3D0 and err is set).
> >
>
Hi Gao,
> Ping? could anyone submit a proper fix for this?
>
> Yes, that needs to be resolved, and I will replace the patch to the new v=
ersion.
I think I misunderstood this as you are amending it.

> Or just
>
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index c2253b6a5416..dfb77f4e68b4 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -539,8 +539,8 @@ int __init z_erofs_init_decompressor(void)
>          for (i =3D 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
>                  err =3D z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : =
0;
>                  if (err) {
> -                       while (--i)
> -                               if (z_erofs_decomp[i])
> +                       while (i)
> +                               if (z_erofs_decomp[--i])
>                                          z_erofs_decomp[i]->exit();
Even though logically same, decrementing `i` in the middle of 3 lines
referencing it does not feel very readable to me.
A below version is more traditional as changing the cond in the while() che=
ck.

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index c2253b6a5416..eb318c7ddd80 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -539,7 +539,7 @@ int __init z_erofs_init_decompressor(void)
        for (i =3D 0; i < Z_EROFS_COMPRESSION_MAX; ++i) {
                err =3D z_erofs_decomp[i] ? z_erofs_decomp[i]->init() : 0;
                if (err) {
-                       while (--i)
+                       while (i--)
                                if (z_erofs_decomp[i])
                                        z_erofs_decomp[i]->exit();
                        return err;

I will send this in a formal patch in few mins as v3, if you feel ok,
please add it. If you want to stick to your version, no problem, I
understand that it is subjective.

Thanks,
Sandeep.

>                          return err;
>                  }
>
> to avoid underflowed `i` (although it should have no real impact.)
>
> Thanks,
> Gao Xiang
