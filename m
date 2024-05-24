Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6CB8CE72D
	for <lists+linux-erofs@lfdr.de>; Fri, 24 May 2024 16:36:39 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jn7CTL3D;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vm6mW6QTzz3gFK
	for <lists+linux-erofs@lfdr.de>; Sat, 25 May 2024 00:26:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jn7CTL3D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::233; helo=mail-lj1-x233.google.com; envelope-from=net147@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vm6mR6xkKz78PQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 May 2024 00:26:30 +1000 (AEST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso31148701fa.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 24 May 2024 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716560777; x=1717165577; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ROqYNsYCoz70viFcGB4AP2EFPxkBToICk7x0Lnkd92o=;
        b=jn7CTL3Dg34t1frKmuJZwoCQoDROU9NUEnRafxRt85qCSC/BNO2YwqabbjQoBaB1Z9
         ISOyf2QbPWQqQ7TweMdBHPSz4cT+qv/jEDkdwEjjihEp0/N7TetXbhUFJDvsN5wrBoYO
         u+M4lx5OnAigw2IwqX4EhTq9LgvZUVe5Zb5JVjOnha2n/bDnkdBcdRe+B2RWwpSDUl7X
         6yo6omkx54jgm6nDhSYuYmFDRqVACCfBjDQet2ZCh3uQMGz/SlYkq8tplsg3re8F6cEu
         W4pZIHEHqEBxmpr9i2hmsBdVgvDmir73H+hy0SJVLX/GVZJOK2O40UuizLqHQGzKeubE
         eRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560777; x=1717165577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROqYNsYCoz70viFcGB4AP2EFPxkBToICk7x0Lnkd92o=;
        b=GwxEY9Q8tMMVBhXipEjmPifoHhn9f7xmcUeaECY2VDwNEEzUPcQ/QSg+F9X5UgCmAL
         T5fC5QIvb83PO+clHeRP8mifmtqXLT9ezY+sN09hsZzyXsSX793hdwYwUrOL4KkgavLs
         qmbwDXbRAMy17BuqHYB4id3PuTYVsjkE7th/281QMenXsrGfhpov7vca5NvC+l71SNTS
         TFQjBbNswL1+K0XlmBA4chcYlof/BAqQ6S8JAJTprGK3DYndiGJi9d/SrGoYWP/Nb/J9
         pAtJY830/HBIdwW6NWPI00UznH5q6z27oDyEVwA/o5F4psTLnKX8tYPms+1nM7upJlx4
         3jRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVymLfrmaMk8M23cj5YqDarMlrm8GIpZYdAzdLpRIitoN1XZHN45zWd3lUEVJTfEqJlIOhlzYPgM6bjeaiIqp+1yMaabmdCezA5dZoX
X-Gm-Message-State: AOJu0YwMgzzItlcxQbbFb2IeNoxWDT8gdb4bdd9SGiFL61rV1Lis82nU
	67UevfVhlIRUxQOrjGgZUO1L8FS4DYKe3JswdQYtvva+xadIjPDLbkQLxIctlJpIP76ftK8U4TP
	+HfCv3bpgpk9K1EPjbiOQHrFild0=
X-Google-Smtp-Source: AGHT+IED7THa5K9ZS5MM/UJZySNFqddmZWUvCFVFXZJy+Db5MIobLYVha/fHTauqpSC+xLEyz3B9rJFYYqIscp6XS9Y=
X-Received: by 2002:a2e:97c3:0:b0:2e9:5543:8a74 with SMTP id
 38308e7fff4ca-2e955438b8fmr14048191fa.6.1716560777254; Fri, 24 May 2024
 07:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220226070551.9833-1-jnhuang95@gmail.com> <20220226070551.9833-3-jnhuang95@gmail.com>
In-Reply-To: <20220226070551.9833-3-jnhuang95@gmail.com>
From: Jonathan Liu <net147@gmail.com>
Date: Sat, 25 May 2024 00:26:04 +1000
Message-ID: <CANwerB2SBe1+0sW1OXHEfSMA1z-vyAvLfAqVOKdsM-ap=KYbCA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] lib/lz4: update LZ4 decompressor module
To: Huang Jianan <jnhuang95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org, trini@konsulko.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Sat, 26 Feb 2022 at 18:05, Huang Jianan <jnhuang95@gmail.com> wrote:
>
> Update the LZ4 compression module based on LZ4 v1.8.3 in order to
> use the newest LZ4_decompress_safe_partial() which can now decode
> exactly the nb of bytes requested.
>
> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>

I noticed after this commit LZ4 decompression is slower.
ulz4fn function call takes 1.209670 seconds with this commit.
After reverting this commit, the ulz4fn function call takes 0.587032 seconds.

I am decompressing a LZ4 compressed kernel (compressed with lz4 v1.9.4
using -9 option for maximum compression) on RK3399.

Any ideas why it is slower with this commit and how the performance
regression can be fixed?

Thanks.

Regards,
Jonathan
