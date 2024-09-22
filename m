Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EAE97E02F
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Sep 2024 07:08:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726981731;
	bh=ilo5E6tJQGAJlEXke9tvGINDBcvWGNiqxNrcjDh3Hic=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=UgKr+V/W0KDU20PDobm38wbm0j0HYJHKm+rAdT3Hod6o/A9DWYXvtkuJE15g1lPcK
	 zFL6zShrDuHnml26Tk4H2/0o15MyMaKiCTpjpqvp0kt0kyPxRvY23KtlKPMCgj35Cv
	 TJt6AocPYe6uvR3Qh+Gd9dh67BOSLKgR7FqYprvoLvpJAkS+NtIvxQr+tPj4LgSgpU
	 E0dH8NOFeOWqcjTPK2kgjOLb/w0t61rI/fzG4nRwEjc1j+zzFnfdN6eaOGt8CKYtCm
	 USSClfvWJ3XYDOnQlnoxKx98hl5DQrm+4tF9a6yzZU2poXQrHilFcg8UfAcfKAtffP
	 a7mxeYfDbxlug==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBDg75kFVz2yVV
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Sep 2024 15:08:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726981728;
	cv=none; b=lVzCqqJrN6kki5Nu5iAFUZr8m81FFbLS8ikUbTgqIjlQPBWdj3GNPdRAFntELAew3z+pELpONcFLFGDxi0b71pEQOlunM2uCoCL6RObop6ZWKXxmLgYd1Tk9Qi6cb/22cAGCgoJvEeDiCxbS1tzO0yyuMD+5XUkoDz38GA7oMfgU7fQhHL0EJmsTQ9zeqhcnrfgQYoRx5UtfERtUbvPjysjMO7q1rEWx5dz4VgSzbyXH0AVx/G4HWULn0pPsGZwdMmKqSpdbIg51dHyEne3ivQid3y2+BKxE1ocRVna/i31/Ay9X2ooyizC4Q+QnvyUboUVee92jMnFGGPiZ6UTSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726981728; c=relaxed/relaxed;
	bh=ilo5E6tJQGAJlEXke9tvGINDBcvWGNiqxNrcjDh3Hic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FvWdkcWCodv44o/YpcNKCWr1jedqubUSEa0l1oMYAQjkoTZcNqo3aUtrz+fW7jIkj3v9B+tYq4YTtM3hR1xq+z0cao+Lbor3/8/+dTQSpXzyVPHZnd9gPBj3Q8SrnZP85783CHWVvK/BvazotQMjvTmzongQsIMwrlYlvP7CTA8UVG+F0GMPwc1e8bmmA3lZDlSYUIFfmaAoO6i0ysQJCCM5okjIx2uMFhJQ27zYNkgRnRTP2RCiuijOlm36LsFIlAjWrsBTXvEf8NEkj/XT2wZNy0RcE0Ehct9IHlZE9+RrettI9as035vS2avWcN6HmwnCp1Fh8kfswB2OoTKo4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=IE9P7ppm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org) smtp.mailfrom=orbstack.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=orbstack.dev header.i=@orbstack.dev header.a=rsa-sha256 header.s=google header.b=IE9P7ppm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=orbstack.dev (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=danny@orbstack.dev; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBDg375C2z2y8n
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Sep 2024 15:08:46 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7191fb54147so2489071b3a.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Sep 2024 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1726981721; x=1727586521; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilo5E6tJQGAJlEXke9tvGINDBcvWGNiqxNrcjDh3Hic=;
        b=IE9P7ppm7gQUELKqmb4O41ADsJtOhs/RXpMg+BkUEYWhihT1m+7ejV7XmaZb509MiP
         aorOz+ludhI2Qcy4nLx7q7Z0V86XUDa+TrJRGSLtcWjAhmzPwodrjf60RIq5pauj0nzf
         iMgF9MfxH0UPLZYxKKx5KHwtiNy81IgvjbhSSg/VGhYIKyTQWz3rz/TI39so9+TJqIXa
         FgEo7EsC5wExseRA7/YDIbGHWot+pA6mSchvNciizIqdaa20Qz9dzOtIEAHfVM16z3DH
         79bUceE0B4QxLyHZPHj72jY5i7dSLcJoF+O2NGKf4NiIXCQt9rgq3iNH5DeA9uzjmWe/
         1NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726981721; x=1727586521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilo5E6tJQGAJlEXke9tvGINDBcvWGNiqxNrcjDh3Hic=;
        b=CgKGS7kO8H1RbNA/7oGQa18d6Hr/DAP3BsNpUYNVsCh+bN+E8F2TOGhQRW9OQZg4/q
         /go7DnFdceZfCpJQDoissU0qyAMdCpIi8grJkBheQYSzi74wPeZISnoodg/d4C3oMuuz
         sIOKK4/ReEd4CwNRaoBTq5GeV0iEPzFcUjkOs+0R7wMAIOGEKJa6bL9ki+V50ArZYNss
         25/NrP4+oga/YkhqTyqNITFWYo/+IZ10njAaPQvEJbvqtOinbVmiEpMe6y8SJIUcZEJS
         LTwuMIFPsQU1BmRsmPIzLTb+6eb/x7i7+6+5i9Apxg7+RdjAnaehAhx8e7+JGhbHcps1
         v5MQ==
X-Gm-Message-State: AOJu0Yzv8dwCb8Hv+rUFLoIX0jXf5PfnkGfbCLiv9tfkCfgFwk32p1k0
	shYgLPyS7Hgwv8OTitL+cqYx9Id2znXLLH4nZoAlnuz7eS7WRDmR3KehEh0fWXDtOtIOzJous2m
	vyV+EsydN8KogdkwomnNdgJ2ZBj2QSo1qKcPt/fOJBJb5wzbU
X-Google-Smtp-Source: AGHT+IFjGfkR0qs+3T/FFxTL5LgANqbC9gb8jnoCzhvaPq5wN/45gKt2MZ53h4993UDQBnoSVIZmiJDNzI7wVLREDjY=
X-Received: by 2002:a05:6a20:4386:b0:1d2:e945:77c4 with SMTP id
 adf61e73a8af0-1d30c9c9898mr11075988637.2.1726981721334; Sat, 21 Sep 2024
 22:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240916073835.77470-1-danny@orbstack.dev>
In-Reply-To: <20240916073835.77470-1-danny@orbstack.dev>
Date: Sat, 21 Sep 2024 22:08:30 -0700
Message-ID: <CAEFvpLe92-nS+4zOv5a=UOMW2whBtsGZ98D_MHv+x_KujEaroQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix compressed packed inodes
To: linux-erofs@lists.ozlabs.org
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
From: Danny Lin via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Danny Lin <danny@orbstack.dev>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Gentle bump =E2=80=94 let me know if anything needs to be changed!

Thanks,
Danny

On Mon, Sep 16, 2024 at 12:39=E2=80=AFAM Danny Lin <danny@orbstack.dev> wro=
te:
>
> Commit b9b6493 fixed uncompressed packed inodes by not always writing
> compressed data, but it broke compressed packed inodes because now
> uncompressed file data is always written after the compressed data.
>
> The new error handling always rewinds with lseek and falls through to
> write_uncompressed_file_from_fd, regardless of whether the compressed
> data was written successfully (ret =3D 0) or not (ret =3D -ENOSPC). This
> can result in corrupted files.
>
> Fix it by simplifying the error handling to better match the old code.
>
> Fixes: b9b6493 ("erofs-utils: lib: fix uncompressed packed inode")
> Signed-off-by: Danny Lin <danny@orbstack.dev>
> ---
>  lib/inode.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/lib/inode.c b/lib/inode.c
> index bc3cb76..797c622 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -1927,14 +1927,16 @@ struct erofs_inode *erofs_mkfs_build_special_from=
_fd(struct erofs_sb_info *sbi,
>
>                 DBG_BUGON(!ictx);
>                 ret =3D erofs_write_compressed_file(ictx);
> -               if (ret && ret !=3D -ENOSPC)
> -                        return ERR_PTR(ret);
> +               if (ret =3D=3D -ENOSPC) {
> +                       ret =3D lseek(fd, 0, SEEK_SET);
> +                       if (ret < 0)
> +                               return ERR_PTR(-errno);
>
> -               ret =3D lseek(fd, 0, SEEK_SET);
> -               if (ret < 0)
> -                       return ERR_PTR(-errno);
> +                       ret =3D write_uncompressed_file_from_fd(inode, fd=
);
> +               }
> +       } else {
> +               ret =3D write_uncompressed_file_from_fd(inode, fd);
>         }
> -       ret =3D write_uncompressed_file_from_fd(inode, fd);
>         if (ret)
>                 return ERR_PTR(ret);
>         erofs_prepare_inode_buffer(inode);
> --
> 2.46.0
>
