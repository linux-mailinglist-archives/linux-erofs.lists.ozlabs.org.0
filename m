Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F087F5ADD
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Nov 2023 10:12:14 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E+By1CI3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SbXSD31KPz3d9g
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Nov 2023 20:12:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=E+By1CI3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SbXS80GZSz2yhT
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 20:12:06 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cf8720c6b7so5133555ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 01:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700730724; x=1701335524; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a72khHR5jiE9UfAcDPE13ZONUVgJ4dYyONT5/rJIE0A=;
        b=E+By1CI3S/dAarJKNNpZiLXk2KeN3Ab5eGrrauVXz/TH7xn28q3OvBMiQWwi7fGlbi
         UhbWBcMFFrIelW62MEZp6M+exKZ4bO2XPWq2rdSIaBlpj7aJx9hd3CjEiQXDapLFj3hZ
         lf1fWqR8kPwKGdnCT6dF4n+ZAeiIa0I+rRw54EFzhY8H01zeCimDqdCuRnUIwauvo/9l
         mYg6SPkia/27SOprv+1dpaufeYscKtn6G1ohjDDxOnu7P95jrJJQMYr8DeoGr11bk8xK
         8PJSMDS2PvY3Hqm+TMP2skKkh2Hh6XBBp5zoCo9VPM6viv1Mb0srRJ24VBysJ3AevtAb
         IsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700730724; x=1701335524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a72khHR5jiE9UfAcDPE13ZONUVgJ4dYyONT5/rJIE0A=;
        b=hm40fc0yn+NGdhx88R8DPN9vFwrhnZi/gB9ukAZSXMltAMGYNwbrKhdsoh6i9BKWwl
         KJv7C6H/tvRkvJ9a/+LmGOxoYKByhsQFHk9EBZxgCVZX+b9UlVTWKFE8waoYxtk5Voe+
         /rgVA8aapcTNZfShvtNoWNybDqFDaLnnDQiUaANZTkD5KNfEGvkzMmctYUvrhvVZ9MaC
         FVUY0WZlzUC0Hk99aMJ1Ncw20pMvu2xcJQ+lyD42nQ2kfdnQj/M3Y9x2PBXszQH44c+1
         ObI6a9tV2S1Qk1ATnrfiKLC1O21X1O/ssiMx5gJH5v7qtffXkl8OmkeO+2XXBAVFiW1J
         8Nnw==
X-Gm-Message-State: AOJu0YxPrEuN3O66HLtaMTy6jRKucn5HLaD/B7CI4k44PUlJKtAmETKk
	H7XFq6tnhLixsJrrqTzBNsC4v7+7s3I=
X-Google-Smtp-Source: AGHT+IERJ29gQhJ7wKoVGoUDg3TOKoglsDbs+a8oTGyz8QxnM8K1vEPzlMXZwk8xG/JJG96svRbjug==
X-Received: by 2002:a17:903:44d:b0:1cf:7a4b:9dc6 with SMTP id iw13-20020a170903044d00b001cf7a4b9dc6mr3102587plb.61.1700730723698;
        Thu, 23 Nov 2023 01:12:03 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001b7f40a8959sm863694pld.76.2023.11.23.01.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 01:12:03 -0800 (PST)
Date: Thu, 23 Nov 2023 17:11:59 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs-utils: lib: fix up compact indexes for block
 size < 4096
Message-ID: <20231123171159.00003646.zbestahu@gmail.com>
In-Reply-To: <20231123052245.868698-1-hsiangkao@linux.alibaba.com>
References: <20231123052245.868698-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, 23 Nov 2023 13:22:44 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Previously, the block size always equaled to PAGE_SIZE in kernel,
> therefore `lclusterbits` couldn't be less than 12.
> 
> Since sub-page compressed blocks are now considered, `lobits` for
> a lcluster in each pack of compact indexes cannot always be
> `lclusterbits` as before.  Otherwise, there is no enough room for
> the special value `Z_EROFS_LI_D0_CBLKCNT`.
> 
> To support smaller block sizes, `lobits` for each compacted lcluster is
> now calculated as:
>    lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1)
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
