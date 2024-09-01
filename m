Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C303967C31
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 22:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725223737;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KW5kTuf5ezCoSzSVpi6BIpqsVfeb5my72dNYr9lAKr5Ga5me1nDnxAQLKR8JLJx1d
	 yC2LO0I4UEzNEzesgu/teEL6VBYV/w68OaRnNijby12bWSSYwZSIecJM+2sMPG71iS
	 0hvUWLK+pa+I5AGkN3ZVZXD6VvgmCkvwU/pG7bS8pdZ054UQ+CmZjAVjmXI3n3/VA5
	 CkFPSoGEaPIEPGH/x5Ft+O9oLriTGIcBBWJbUIgYJjkYhzr/gz5X3MkLx/HXR0h1KH
	 LHC4QPLEmcYx7r/ceWuCVVmaGzikBPlDE8y2OmbtnM1jVCfmtdiYbBjNNxxyjKXQY6
	 +PySI1sreWxCA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxkWY2hCVz2y71
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 06:48:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725223735;
	cv=none; b=NZ/HpAMIfwU0GgOl5iam9UE9XGPN9Wt2homp0JAZmWkjJ2BU0FvOI1lct3v75axZfzZZrxB0+IENlUHalPyYsMPZ2cMrF0gAoDfpa4CG8yexN0ESK3CA0J47ykI62yUq3kRsTL8wGj+DSxHrHZameeCBUoLkXg390VlcG48GTNIqg6qRomqMEONpmof2ixZW0zcN0VVyDKL5H9gTRVvM9My4HnShuKCIaOjLztwFDuufEcUmmLIYsXJvT8n7GlcoviM9sVanaicbasV3/+3vbB6LW2QJYb6l8LVHL5bzLrTsvnk/AgNeJGhjyo7l6W77UCoz/V3UIMTAy9cXAOcL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725223735; c=relaxed/relaxed;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=H/2wnLSC3V+5fNnvq0B2wASyMVtc4b72RSZhRgXCevglTHb9hOKZMemr7Huscac0Ftfx4+nSb3KUOwB4V9mmNtd1JfetLGSxzXZPzOiPdxocJei08vY6eHbxCVKaaKrMSI6jdXNsGgCfAV/V/geLyxXSQROs0spHkFNdGg3nTvCm1Wo9N4O1wYTs41+SckxGd9nEMDx495UD4gxklxda7FV1OLtx9zw2c88eQAXL9KeiDeJemIPo/QeORRA8QCLR+BHBw5jjn5YOckeo85HvP7qJQePHoqonGreB8cMSJhpHHdGMtyUx4yOWXwShnVRy5kgKwPxfyNsSaHjLXRfpwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=bSY9ljdh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=bSY9ljdh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxkWW2f4Zz2xsG
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 06:48:55 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-202146e9538so28756815ad.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 01 Sep 2024 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725223733; x=1725828533; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=bSY9ljdh1AcHRB+jYI/U+k0Yn5PxJUNIfJQuVMNgLqXagerSLpSOhizbKOOvzQGs4R
         gzJt83WIRANyETU/K9yy9EkCEh5D3VcSHkKydQ+NVmka4bn1ZzjeD9CQqjRU6Rpykw5i
         bd410urUypd4yMY2mNkgpsdoOuPfwziOY7ukYc2M8vh+vIfvMakTZ0sPGjNcm+4rv/5J
         S7LD0pn/iIGgxtW/6VtxpEh5bN8HgPpYRDN55ueYU9L1JILGCCm2ZqZydTSzYaI8cXve
         NZcvJ0lvR1dip8ZMKoLOA9SGimbTON8tZgLh6p5NCzuZf1c861U2ErYXV3WCv0fKHAPB
         3l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725223733; x=1725828533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=WZ++GMZLG/8IE7Jx4GMF5e4ykwf5fwxEPveau0j+seGE4BuOYhc65GcH52lkNZsHmq
         VjAbKT75kuDVrkstZjqdoR75zh1vCgkqHOlAia3YBQtgewPnHnKAmhXegXR0jSYKglCI
         OjfRpsXNt09sL2lUWrPFG6SpPvhrKSb1w7nyM1Jk413W+qtY0Uzs92b51sQkNGWhVk/r
         631m/Hl0IT+cF7LxBVUPAAuP++jzYAuIcdLMTHbkkw6IvfmPjPyi1tnjubS/vHzFX/4c
         8R/FafJrhPMi2xp0WIZENwpitsLYZoo9K/MezPveim4q4EM+PVX+lLGPpEmsogku5gC3
         D9MA==
X-Gm-Message-State: AOJu0YyMbaPmtAhKQ3xjPEjIsZZ0JgBGSGO50tZzq+A9E6u7kRWBdY3u
	5v89jlM1dUllqRhOO8T6RSw+xtDpPZPQfZCKYVzxQsIR79L2U5LAFuT7AjPyFqCSLFEM4SXI6GW
	CapqkRObr41HFsCwfJMmHuxFbRtCCU+MAW5PW2tcaTF5wT8dTsGX3
X-Google-Smtp-Source: AGHT+IGzJwAg6SK3VulTWUXWEJfxMigXwQryE/TP6iOA6IZGIyDtJo5CZWpa3AwuhqI4oGwVF3TIQYiK3gj9MrTxy+I=
X-Received: by 2002:a17:903:984:b0:1fb:62e8:ae98 with SMTP id
 d9443c01a7336-2058417b104mr3536105ad.3.1725223732671; Sun, 01 Sep 2024
 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com> <20240830032840.3783206-4-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240830032840.3783206-4-hsiangkao@linux.alibaba.com>
Date: Sun, 1 Sep 2024 13:48:41 -0700
Message-ID: <CAB=BE-RHz0mx=7hTz61s-6eSQw8X4bWW2eE07ih1_P317WCnxA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] erofs: mark experimental fscache backend deprecated
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
