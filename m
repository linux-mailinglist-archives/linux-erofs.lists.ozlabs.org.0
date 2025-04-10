Return-Path: <linux-erofs+bounces-189-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA37FA84F72
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Apr 2025 00:00:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYYfV1jYzz2yRn;
	Fri, 11 Apr 2025 08:00:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744322450;
	cv=none; b=DppMQSk0s0YnTAkxRkdIU4ruvwaC4gho37DgKOrShwp0Bk64uYVWE/ZQqsVMTruQxaxhWkWBpg/3ibD7NQo7ZLmQvwlyMZ8Y4hXgjm/4Mhon2b9vJ09BVXZpagnZkHP/fEQhr3pQugP5HrLPvuP/aNc6fLgarNTiv/mAdH3SqKHeRKZRGqlO58WNx19B0tEmAiFqu9hBw4fah1XdN2mFvU49fhLa+BRGjt38lCVyIe8PQGCqBaml3FdZwhDUCMue5sgFCPXeMD7aWeiQQxlzASQzY3uwuChIc/I8LZ/nI2h6czF8eJ2R4VHhe69m7qenRFNhjq/FzKoobWeJ+a+KYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744322450; c=relaxed/relaxed;
	bh=EMYq36ZteWciEgN8wl0wsvoFmWINT4Ipk8qWUaNjOHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8AAbSJVUgu+pnsX5xCLyk74k7iBRnAS3npvcYJxLa+uQmkUCaHdZU6dNL/mDG6qExUol2XPD/Zgxfvb57FI2gT2ZejXQGBiosHaXKRe9TPGqenqFmNT07lKUvP6pt9NOEXu4llRD+bDqIDDwnQwrLb6S5gx+rudAvH2coJmDRrmWxajEWJkHm9ivr9n3SzknpWpQRTvFJfKDNFtnFsOCLqD3sm+/mPrv+0hjXElC1GOvNCC2dUInbm3wAHOgzTAoH63MHPDFalL6CmImnjK+/pOnAJL6d2nhDLkTFYLJUab6e5H1ECP8k3+EJbmiYBWB0N1E+ywn8fylzQh9NW7Iw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=V2m2CDwF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=V2m2CDwF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYYfS5DqQz2yDH
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Apr 2025 08:00:48 +1000 (AEST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso206273466b.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 10 Apr 2025 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744322444; x=1744927244; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EMYq36ZteWciEgN8wl0wsvoFmWINT4Ipk8qWUaNjOHA=;
        b=V2m2CDwF8KHkp7/k+gKeQrwXZn99Cx4PD4ptLL+JieL82PXUKxJefnPbD8lgF2XWWv
         CHXzrFQgW18P9/xHhU/9MFBAj0mgjT40Al34Bma2KJ6+2mo7C2WtcUGLZaJferBBNCCn
         AABX/W1at8PN5BXtABIEJLdP7FlW3EkAsLbEBKKzLN9hZIJ638HYVAAmEjGFFEGQcbyD
         Ape6gL1UjO3iR9t0KSAcO8KEMQvseXPcPTvZO8kRA8mK4SOD8ZqVsTXmym3XrJVUcPtS
         v+ydHPzruqfmzrhYJ8eUgHESJFM+rzS07lYc9Fy3DpUwNRBzDTfcSKlPbNSw017b0giQ
         eU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744322444; x=1744927244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMYq36ZteWciEgN8wl0wsvoFmWINT4Ipk8qWUaNjOHA=;
        b=j5Blm0h5SLJQRrxeupCkDNYRM3MqBeBUx/FtMiD8Esk0D32/uMlA6Zc3eJwopoPDjM
         vnyMfmQAZKOpFNiY2amU8Uy35YbEVOb9X0Uwp7ypgfGp0lX8xmNRPi6QaaC9640lOfgL
         XgCPO8Ks8vXUT4Ax/1PRaRv4zOUVIEJuc8H95H66VUaKKo+5YjOr0Kzl0lCZ9zsZPOL2
         HrvGBY1y0MCBOamInwFNMAJXkP3S9L04DWLxUhNyVUkT4KC14lFwSDI3ySJQulwKFzLV
         OCJUW7UpXOeNrsK71EqKzEljGBealo5IDeA04jcbV4YTbL6IGDnpsqpZBr9ljKb2apn3
         +TCw==
X-Gm-Message-State: AOJu0YyThw8WztEAhBcq5/2SApxJV/uE+ogpoxOjr+vPBGiQFUUbkoCZ
	effBWhyt5P/mj5DHomVP1wGk3rD5tac+Uti7v9QIr/Mrjzzla+qFk/6SVW+gaB1WBcl6Dvuj4C7
	76GvasfZoLJvEFj/+kOOMjBDW8NzrRizbZj+t
X-Gm-Gg: ASbGncuewuwrP/EhCO+Z7A3u4P4sGbKHyWADmJYYnaxc3cgMB5UZorMHPGUB8fuCUjf
	RujNuEHQ4CDDy6DEYORCTlpgviK4JuAhwfaBylIOjEjccyHvYhHWp8R425j3x7H4oTSxHWvBGbi
	1knnk5blUTzAnTUVtlygvJxnxg0QhE2vkfpGm2PyJWDdC8JiBdE/Yw
X-Google-Smtp-Source: AGHT+IHm+wXDFYjpDYF3y/dfsc8hCtmgYnE0zBpmZMDFX99ZWKTmxqWIeyMShvR1QyBW76z+X7d/UKYRIy/ckLZBR7g=
X-Received: by 2002:a17:906:6a09:b0:abf:742e:1fd7 with SMTP id
 a640c23a62f3a-acad36d0442mr20536366b.57.1744322443821; Thu, 10 Apr 2025
 15:00:43 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
References: <20250406112735.348328-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20250406112735.348328-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Thu, 10 Apr 2025 15:00:32 -0700
X-Gm-Features: ATxdqUFysUx1T6dQitxWeORsLgnyk45qSf_IoPggCTRkfRI3Wxd8d8PuZ13Wc1M
Message-ID: <CAB=BE-SoRgMXVZF9fqFKw+_sCNCNp3hYznL4oWw44+spgbzWNw@mail.gmail.com>
Subject: Re: [PATCH] AOSP: erofs-utils: mkfs: remove block list implementation
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Kelvin Zhang <zhangkelvin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Gao,
I checked with Kelvin, and now AOSP has an EROFS image parser so block
list functionality is redundant.

With that,
Reviewed-by: Sandeep Dhavale <dhavale@google.com>

