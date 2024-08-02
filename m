Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D39464F9
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 23:22:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722633740;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SI+FKHUYfAK45mYBrIvmVlvEi74DuKtSPCfknO31l553dnHiT6lgN2Ln3IY91X+PA
	 0VredqwkdVGSPxcxqcTPzjlGOOhyT+amJ+X4OuwEtKyK63wYY0wzt/YnYflZBYxSqI
	 EqmrhSQw4gO8/cki+uunsLT8yScksm05RO/oCuQLPEjBJNpOFPwRbE6e4z7a/3D6oL
	 s6vVN10q9Ze98bLG54bDNMX7Vq31YTY2PoVI2t5G1LbqIU945dCOjVDpPDc92DViVT
	 CJsq+j2TDCM9pBfhJx2/ahMHggf0hqUtsL3P1tLc9p0RRqIEKl6+bjIJ53NXjfvvOi
	 aMTTrza37IMdA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WbJgw4tRNz3dXg
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Aug 2024 07:22:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=rg/c6qye;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WbJgs0LTyz3dL8
	for <linux-erofs@lists.ozlabs.org>; Sat,  3 Aug 2024 07:22:16 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so49431225e9.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Aug 2024 14:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633734; x=1723238534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=PVhr42paO29K1k/mku3lRrOdxLEaj32h66XRSeg1X58kVaGpE/zIn4/o8dKBYK8FEM
         y50oLOlesfpFXNqLLZ+5lT8e0V8E/iAxc8BBo1Zf/pzjntaw5VSrVXUvfWY7OM/2IwKq
         Va+WhBu/rE0jlmmcV2x9+0mgdX348lVEtjhVxrwB4f7hQzz7ZBZWys3RUmV2hLYItzy5
         aw4G/QUvJeU//poDq1BsjTNwKYi5dkYAtaczwZNEYzmRv6IOKNoWsFA37Wn3ltMyhWyl
         S8Cq1u65IS6nnxIzRb1mS51FCdjIufRqiaJ5byNewtijV5aRlG2BsBNGjEDnnG8cf9HK
         MB1w==
X-Gm-Message-State: AOJu0YxqCaEnERBMi1RIsNHmi/b2N3B71X4CotR0szLLev4PToRB5Sg3
	vdUUUyyAdGDev1IElsTyYBPTyzoazO6LG9kwfaC1KrpyXITgtAQlkmMQUcUhhBddj9M/BHsNTWS
	+h1oH3Zdcg6L5Kh5utVeXkqC6RMzflqOlYgKa837KDlsqk2CCbCmoC0Q=
X-Google-Smtp-Source: AGHT+IEnl3KZAPVXPY23x+enN7U3PrlPM+nkKJPZlWBn4WKp9ojVzKq4xeTwB1aZTvUAQ3rtDcqUWkqE1j07tMpVo6M=
X-Received: by 2002:a5d:4849:0:b0:366:eeda:c32d with SMTP id
 ffacd0b85a97d-36bbc0e96aemr2710275f8f.31.1722633733957; Fri, 02 Aug 2024
 14:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240802015527.2113797-1-hsiangkao@linux.alibaba.com> <20240802062316.2368403-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240802062316.2368403-1-hsiangkao@linux.alibaba.com>
Date: Fri, 2 Aug 2024 14:22:02 -0700
Message-ID: <CAB=BE-RmhN1hAZ1559VY5LffvP11g2LtNaLQi35m-Q8BG_aOSQ@mail.gmail.com>
Subject: Re: [PATCH 4/3] erofs-utils: lib: fix potential memory leak in erofs_export_xattr_ibody()
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
