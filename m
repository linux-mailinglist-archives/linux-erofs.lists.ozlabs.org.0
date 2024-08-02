Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283269464F5
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 23:21:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722633679;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ekVQ1GYiI6EHhoE7lAR2uEOhNSrFyhzDZUMAmZndBnNBrPpcJU8yBiN1zCz56Vicm
	 KMp4cbtOF+1IXeDWqNbAEXdxOT8SDjCoH9wCn0m7PFp2ohpOrzQP0Mm3jpITY9mVwy
	 TnfXG2CUagOpHNBBtOdxn3QvyztIG+abHYouXVWJQFdc0YqZ9h4bGhN8UxlLSzlAi+
	 BkA2E2ryHfo+WyfQ3pnUQjbK7nLp4qO5amB19zzTHJY8J1EvNTpfPxxZTiXhnpTa6C
	 BrCQP9OJpn3hdu+Yp61PPQV71pq5UzMKR2SJiGNxTdAcceu8HVAw9lZQWb4AQzlZhS
	 tLHjF2jMW6Mkw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WbJfk6w02z3dXg
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Aug 2024 07:21:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=koygeyk5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WbJfg59Zxz3dL8
	for <linux-erofs@lists.ozlabs.org>; Sat,  3 Aug 2024 07:21:15 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-368712acb8dso4070014f8f.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Aug 2024 14:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633672; x=1723238472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=Ee7HQVjndXeMx81bn82pcajtiyu1+6wgwRTA7CSircIo23yq4DYmplq1KwowDsTl6m
         KWvAH/AbhZ5UJ59dEmiW1q8SW0czzTaDGpfYhrYBQuWj0hu77jbe9x1qjSVZ5Dm3zBHb
         akS2QpJ11Vk2+KboZN+0vjTAtdCwSohcAHGPS9x5N4C3f1Z8F5dQK7PYid4BBptkEc/C
         NpwRCFJTh1fUHOCHoTmi2oQk7PCTf+MVUW2dL3WEGeXDgXiyRfWixl8OyvmTlF1UMv3B
         lcEFS3B+MZns950MQyW0wmHO4AZQOaIrq8SC3EQEWA0TGirV+HfimLL8rCZQ5wXADv2Z
         LsPQ==
X-Gm-Message-State: AOJu0YyAEx59lHFRdJs4ihdOiXGMXJkL96AL1UOev+KizJboZ9zQPAg0
	/s6ApFw+4QpRCr1qMOTInC/lUtrP+n4Ocy2yeW4Ggw+Fquy/LSd6L89H+xyNp80kSWv2kwjyzXH
	+FsZ3eZrAN/jFQDLsU0TnQqCUFPEmXRz637D9
X-Google-Smtp-Source: AGHT+IGSzzZeALEwhK3OaV1UZVosAiQB0hJEZ2mHKFhtvSWg1ERM6Gs+ZNOIOW6lD0FMvujL9laMcIRjbGA76qEL8NE=
X-Received: by 2002:a5d:6b10:0:b0:367:8a2e:b550 with SMTP id
 ffacd0b85a97d-36bbc182304mr2899580f8f.60.1722633671498; Fri, 02 Aug 2024
 14:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240802015527.2113797-1-hsiangkao@linux.alibaba.com> <20240802015527.2113797-3-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240802015527.2113797-3-hsiangkao@linux.alibaba.com>
Date: Fri, 2 Aug 2024 14:21:00 -0700
Message-ID: <CAB=BE-Q+r8QrCLaS8GjzAP75XzJsJ4s=8JisLG4aLiqKDA+KeA@mail.gmail.com>
Subject: Re: [PATCH 3/3] erofs-utils: lib: fix fd leak on failure in erofs_dev_open()
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
