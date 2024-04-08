Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC5B89CEB2
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 01:06:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1712617572;
	bh=hkntsIVLSnq06IArFYIAWTKVMmKAQGAtz41uG4WUf3A=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=fpEPXNV9kss0nPLSKGbsuxUlFf1QAP2C1esfrd9P9n0lP/nwRLkO+3eL3ci5QStp8
	 Wghh57kePWx80y61pg3XK8tGPXlZzdKSHQdozN3BYCR5mNfUNwROlPz+aoaPO9cbCN
	 YMbUps6rAEn+jgGJekTqJ4eCfxAOLzYCsRZ/0Oya1/BvzeCRgwXCsAYccK8HLAd5f3
	 wcPIUHA4Uxh2Cc5UO2HDZoaN/v5AyNWJvwNcbJ6/yvdTgnvgSFGmV221ouBCeQ7HTL
	 TckB8aJQ9plJlcwsfE47CUa6K9ziNr1bYOhz4TvU3kINsRX+h40yrySH5EtUguBOB6
	 KkFAabq7SOHUw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VD4TJ4WjMz3d2x
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Apr 2024 09:06:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Vt1bjoFP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VD4TC0sFpz3cM4
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Apr 2024 09:06:06 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-343d1003106so2999131f8f.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 08 Apr 2024 16:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712617558; x=1713222358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkntsIVLSnq06IArFYIAWTKVMmKAQGAtz41uG4WUf3A=;
        b=ge+qDCaH7X9+Af/sdMTc0ORwyNmg78cZsSHCRTfdENuAC1fsW4UPtdIYdr3US+Mfmk
         zpZQgyJlBLkxrmkFT76NRqnIFJ/baaOYDtTO15oye7Nj13BoECPT9tUGxq0NKV7vC/j0
         nmw13UkYo+KiNAlw7uik/jwMbZ/IGoq9NWmtAje3DDyfGeT1Gux/9NAMPrjz+EkvyRn2
         cmw6DKFrowq0mBxze0JCYrxdT3Q/CgrQjgxYRRF59DOpNIOn0T/rYmr+rr+Sl6WhvxGo
         skHLZ25JeoogcC7qN1YXe14vPg/UHpEHF+67XzA834L7Tsejomkt3wy9Hvpa5wtoTkJK
         /dGg==
X-Forwarded-Encrypted: i=1; AJvYcCUqZPV/qOwZ51eRJEjmHtQ4RXvZTTFBTJPgC4aepn+22t3NN+WGdh683jc+9SHkRi7zeRC60neeUdD+sGyn+IIvKTot8tBriXNIYsUg
X-Gm-Message-State: AOJu0YxBIi1whEyWI/+/qX37RyCqDV+6qG8ROYePDB9rz5yabinEddoN
	lZCPpmiDVTNjV3RL6jaRPyiw5FeHcBodmCCRKncil7onYAVVBJfDAbC3KU2pZPUNutrQi/I2nWT
	hqbXivTz7eMkLy/85BXPLXddN3ioZ4AhKc4CV
X-Google-Smtp-Source: AGHT+IEUa8WcVHFto1R3l6anB/80nRTHBZTKX/MejwEbvI4B4B3HOMp8ZJ48Wg2Y4tNHtAUpBatHBaueD4tqBsUNTrQ=
X-Received: by 2002:a5d:4e88:0:b0:343:ae03:2a02 with SMTP id
 e8-20020a5d4e88000000b00343ae032a02mr7047507wru.40.1712617558251; Mon, 08 Apr
 2024 16:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240408215231.3376659-1-dhavale@google.com> <3b3d0b99-f7b5-4dcc-a631-1018f4025acf@linux.alibaba.com>
In-Reply-To: <3b3d0b99-f7b5-4dcc-a631-1018f4025acf@linux.alibaba.com>
Date: Mon, 8 Apr 2024 16:05:46 -0700
Message-ID: <CAB=BE-Rk_Rxd6aNP99m=tSMt4-tNH4xKru8f1QeOF5fzd8-Mtg@mail.gmail.com>
Subject: Re: [PATCH v1] erofs: use raw_smp_processor_id() to get buffer from
 global buffer pool
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
Cc: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com, kernel-team@android.com, linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>, Chunhai Guo <guochunhai@vivo.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

>
> Thanks for catching this, since the original patch is
> for next upstream cycle, may I fold this fix in the
> original patch?
>
Hi Gao,
Sounds good. As the fix is simple, it makes sense to fold it into the
original one.

Thanks,
Sandeep.
