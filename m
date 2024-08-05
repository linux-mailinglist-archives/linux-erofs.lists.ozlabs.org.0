Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6069E9481FB
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Aug 2024 20:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722884142;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Wig1B9GScxHIblS4ijxUcnzzq2i6ca7c7L43AzRC1hHXQy0l6yDgK1OH82SQNv92R
	 6z5GTI7q3x4/sHZCf4adnvZlDTJC/LrAnRFiAgOtWNtKZbIfy1wxwKuvMRy94LVrty
	 qAuNc94PErU17pHVB/hvXlykXFbsfUdWC2yPgV4qMuivczYcIj/YbEmpZd1H7MXKk5
	 V00nyADDn6KorS/AvOkjCRULiytdwCCcFsA3vE1n/gNmjDvDSVEVoeeFfmD6fkw3SY
	 feeQeWY7FsscrIYm2O23obzc/+nZMwzCrYBE3JpBkewvLqUatyLsU5VnIwUXcwl6gd
	 B0XRCA9FzMZyw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wd5HL1xwlz3cbg
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 04:55:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=z2jinEfI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wd5HH2DCPz3cCb
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Aug 2024 04:55:38 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3683178b226so5664957f8f.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 05 Aug 2024 11:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722884135; x=1723488935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=tC+P6giv+jeFUnfOWpBNyoepCQXGKk9YQBOTzW05Jy7Ri45c+/4JWvBFtit9cLCB49
         J8jgCXfaRSzC1XWC7x1W7fcKnq3iDqza99n2yYVyPZWEOj0s2LKY8OPgmZCcIoCv5yF8
         HedUVgt4Z5B4dgYd68v5bNlp3+TV57xG/fh7cagnNNIMrWoWiO5rkziFiq2S5/MuQJRd
         Hk30i9LDsk9/6Z3ch+kicV5EsAO1G+hbOoUcOsN3Ps8DwYvzNG/9q94j7rRWNOnIrh6P
         O/8ENzX9fRzFd9uVXRP2kFMhZotghwOe8ft6+b2rjOScFejWCsC7s6tivwk08i2wsoSY
         jRvQ==
X-Gm-Message-State: AOJu0YzRrK4h3hmng+sERowpX2rfDqyySAs8c+SkuHxg6VKQpc6SZ1Ol
	9s+ii8lH0tjStAI70qwHVGWP58dQ5puieM0zNwfe5orfJ2wLF+wyIrtfewuEbCn9OeSI8h3iUDz
	wUjQRb4UHEG6agXqbMS08Buz7ElImU3nE7J0gkRc23wKUkHXCIqRlSzw=
X-Google-Smtp-Source: AGHT+IG8/RTAxaC6pKkEwsCbDMYdzzILTxTzw9egr67gLas2rreS6+hsDLXNnQ5Q1KTR+zGL1PZTzFMhAGnu0W9zun8=
X-Received: by 2002:a5d:67d0:0:b0:368:7a18:908c with SMTP id
 ffacd0b85a97d-36bbc17c13dmr9491768f8f.51.1722884134271; Mon, 05 Aug 2024
 11:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240805073953.2864289-1-hongzhen@linux.alibaba.com>
In-Reply-To: <20240805073953.2864289-1-hongzhen@linux.alibaba.com>
Date: Mon, 5 Aug 2024 11:55:23 -0700
Message-ID: <CAB=BE-TRuVBF9Mn+fgcpxe-Xjhx15NSo5hqo3SD=soRFUFRy=Q@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: fix uninitialized nblocks
To: Hongzhen Luo <hongzhen@linux.alibaba.com>
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
