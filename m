Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE5D967C2C
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 22:46:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725223589;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=djCoPHTV34LtJmLeiOalRIc7zRBH6EG+yeuvtq+P8R8GsPtvNf3bxT/BFmS6+yV/h
	 gC9T0e3jq8jiNO8Uy5pOZ7n8w2s7jMz06ftmVNLZf5F4fHQy3EeVH/4FVmq8edLpqA
	 +aERkJyM9nVrSMWNpvtfL8nAUoF3sJWShtBrGtihp4tousGB0A+vVLLOKcFfi+OX5E
	 TcHYIptjupgsZyNzfp35+ZFFPO3bwe2HSBz4iR0az2FxokLUqEcKqAlCSAJrNevH4P
	 JZJsyGndCQWAIXOFdQRa4YcBaOKi1tkMIg1aKo6f8VzaekRUJ9yfTol3rxR2aaFnb+
	 C4vtJsajwIAmw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxkSj3jK6z2y66
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 06:46:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::12e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725223586;
	cv=none; b=Y+83IDcAR2I7PvutDqPJNEwcP8PE/jK54QIr1SvjAnUFtMkffGpa3xw/5zeG2H9MGmf2rc75abAwb1PMl+xRQRj2a9bF6wnV6VWvRZ1CwOCrOiGsc5kKFCYEeLT0wuxPdAQLwzH3CRUz8wEcR85CX2A1rAUNz+sNDoXYJOOruzE8OpaXgQrkyCIUpEuY5laPPRTt9cjofGHPUqywAd/VnR3IB0uy1Vh9hV3xx1wl+51H5EnzHRTHY7eYYbTpsVJt1EfdMF4IsZ4xxqwmiAKVUZheD2eo5W+V04yzjnBRNg/W1iLhwizWEdshwbstSsvUBlE8dc2pFVML+ZInUlNUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725223586; c=relaxed/relaxed;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=VOyCDjuVhtBhY3wkC7yVyJeLljI+xyKRML8ezce4yUaBWI1DmiSq8hXxPIhDowoaHybURpQWKiaIVkhpUBef7XkxPf72aOQLnGAw6P8dNkaE9jwHQnC7hvStmagYrmvmsI+RG25VaxvNpQinE2Pg5j8vy5JSKpw/vpfEuuxwYZBNrvLQYJBTm0QwTz68wz+n0E4y8W5CElgNik+AJ1AqTwZ2lD4dysHO2DvTScuHfjKEwXNsdBsmS+DaCXf9h0O2ppr05cmkDhucdh2tovaNGpNpvTBgZ35qbAxUE6nO+UbFcE+ap4L0y+5ERH+Hfak7AMAFlEKKoYc0CklDrC3H1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=KCKndib0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::12e; helo=mail-il1-x12e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=KCKndib0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::12e; helo=mail-il1-x12e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxkSd2cZhz2xsG
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 06:46:24 +1000 (AEST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-39f51934f61so4489425ab.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 01 Sep 2024 13:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725223580; x=1725828380; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=KCKndib0UvMakVD2cWH0rFbbdvf9tvz9AgL9n/ksTAkbMRF+RGrGt7bXopFcYlEu0c
         37MiRDHh0Hx0EeUJnMYqxVmVfJe5Zg9vmprWPikrpzTQnmnVW3phs9nE4liIE7Dqdhlx
         EnQLzVTgnmvui4xdwad8qFQgd7Pl4gSuAqxg+EontjB5RuCaJkvTijvVczU7x7S3uZqu
         rdhAJ8Ua92n6PsDSaxNtW1VNt2iP8gBoSoj3CqV0QFqJFLwVYhV6zPnj1v7aJnz6gAbi
         aUtBjOEY789E9lErEUoudOHD4UZyk3XJAEoDIyNhXQgasfpAAN1xSNCANL7JAU8iPazE
         4i1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725223580; x=1725828380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=XmgIvi+svXHvXZjHN8SJJy//G86YLG7vz2ctA18jKjz/aJVFDNJawsH0QPQkt79UKJ
         vXXf64xlyUqtX9A2FLCYA5wKgZcQWR8fVQeRmdwdNHhE6ZOXnIhF9Q/q5cFxJyHGexy3
         kV6LEX8UIReikDyUG7KjvNyb0GQzfAnsuGkToOpRv8tBtb8gMR3OyujmSqIks7ZqK9XZ
         +PNOkn7EqL1bdfbh/zrdqg/B581FXLJP940741rliuUwKktaPuyFpVYVVPouAIw8coLU
         28xdsuRb/hHpq7eUMABGXD2+3aAj/RSFSpN8BU2caeHM8UlbkD4cyxBmO8m4oSUlvppi
         Bgdw==
X-Gm-Message-State: AOJu0YxqiKs/STMBXz6my2QQKESwrzcb/bSkzHb6IX37nUHQegefwAu5
	fO+4kmutIzvTXyzRd00pUBzeaGCMWjIEk2cuZ+JwGc19p2JXLIGm7nowCawNiT1DylplcKVPU2l
	zmD8gzp+j+GeIRPEI/R4zr2q4yrEr40bi5yFk
X-Google-Smtp-Source: AGHT+IHmnfShwtx6VepKHMM6i2yw906FV5rc7MZy74a6uTODE45wt5dnmbwXgTLwtQCGPRTV9m7U/TUt1B0c1PKxzLU=
X-Received: by 2002:a05:6e02:174f:b0:39e:78d9:ebfc with SMTP id
 e9e14a558f8ab-39f3786ba0cmr140636625ab.17.1725223579678; Sun, 01 Sep 2024
 13:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
Date: Sun, 1 Sep 2024 13:46:07 -0700
Message-ID: <CAB=BE-RHBO1XQWyRTJ1=rk+CLSTBrQcmmNONA3TaTshZKesYFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
