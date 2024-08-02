Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5469464F0
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Aug 2024 23:20:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1722633613;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=T0Qxv6HUZScYeMhoOFh1+KeRQQe6b+cts6rsguf/WPz8uD2+jSh0bK8TVN/sCpVFF
	 XlEdb9L2OXG2CrsEgAnlUjtNsLNbkJBC/dAlBWVYp3eZzGj7flYC4G3UAiGQjFz1Q7
	 aXLEeNfwnBucuvPWVk7OiyLx/v+bGh6xza7oKXBPK3lWGJ/P9mgvyy6btoyomI3Liy
	 eieFKCrmQjulishyBRo0CVRL0yYtEZrfzI8HBy4oYNP22dirAArlzoryefKty72rso
	 62z7k4IVFBu+b5V3oMVYQ2IH2+zu86FQOE946GfBxc1zS+86e0ofUiD4fw3Zibwo6p
	 x9KUZHR+h6Ddw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WbJdT1swXz3dXg
	for <lists+linux-erofs@lfdr.de>; Sat,  3 Aug 2024 07:20:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Vnf60OEE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WbJdN6CSLz3dL8
	for <linux-erofs@lists.ozlabs.org>; Sat,  3 Aug 2024 07:20:08 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-428243f928cso35438315e9.3
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Aug 2024 14:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633605; x=1723238405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=wLUuwpuVIBY9d1TPuBUl/4IPRtyeG9kgkAPXrDeEcquiUaliwG0FG6VYzvRwYGxxHs
         494ZBOf3HH0ZU9JmlXWg7gjOYhmb3vAGyh2E6WQhetbs7SXlgeW3n0ExNQVZ3q/8HJdq
         LDE1jmCCjDHxgFsY1TzIunEHXLDJhT03QxtM/e5QnlQe1C2ivceAseQOF1cHvaYrI2Mh
         g2r39iytsnGdUB11fTvMsfDUw3nMB7Gr4iTwOhjY61VFPg/0FsZY3n6ytOFqgN4p5vkq
         KSFpozr4+EZJRTpN+nTLuCY1piBzhaMuR5k2ckvf14HqiXrNSveSYTv8CRNxmGOEVf/z
         AbpA==
X-Gm-Message-State: AOJu0YzLA3w2gpJAeldJZHE2nGGJEQWk3AWEHhB0pslKsPiQLTrZD3fK
	lk79/T46Zcnj0aOj/FI6ioKiPOavz4RbpmLXE4t5hWVUiEIxy00ouP+BYQhzw03OzR00SjTHM3+
	gIejfrpkzygMtn9QpcQ57F/hKI29bDjMv8jvVkocpOBpvu0rcAD94fj4=
X-Google-Smtp-Source: AGHT+IHQbkLvycRtUgenI2bFwkadn6u8+Qy7BzgbB2B7r2af2gkO5pIkePAdDU623YARzEK8YnZzU53vLOXtsthk2qs=
X-Received: by 2002:a05:600c:3547:b0:426:63b8:2cce with SMTP id
 5b1f17b1804b1-428e6af2fadmr32097575e9.7.1722633604389; Fri, 02 Aug 2024
 14:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240802015527.2113797-1-hsiangkao@linux.alibaba.com> <20240802015527.2113797-2-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240802015527.2113797-2-hsiangkao@linux.alibaba.com>
Date: Fri, 2 Aug 2024 14:19:53 -0700
Message-ID: <CAB=BE-Rri4NDL3cVcu=gG_8_yVZgwpKvzGOGWLK9ys5OZc2SEg@mail.gmail.com>
Subject: Re: [PATCH 2/3] erofs-utils: lib: fix out-of-bounds in erofs_io_xcopy()
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
