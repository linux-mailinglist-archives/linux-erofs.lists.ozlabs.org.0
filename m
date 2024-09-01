Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A809967C2D
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2024 22:47:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725223640;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RrwDnRvVVqysn7sD527wKQXLo/Ee0P8WRjQFfQihgXdb5E7Zpi9oZDLVAk9zgxWtd
	 kw6bteVaKFLW3F0kw0xtMj/B9zkAb3zmhj3DVkV1lLAD+rAn7Ze6id3PC4DUCWmIMf
	 OOEIPYKuoU0u1nmA8bVEw232HtFnh12cxRVD4yuAXoVx5kvwTZ6wM5AaeFLhvMpvgH
	 VHwhnQjnGItX6oFPMcwIBJxeFlzd+ZWIpT94lsI4AkS6D57O+adBXdPikLcU5aMDDF
	 H3ZXvmvX+pauCsXPfJxzQXUBIY2yCSORJC0FXHrUV7sLCaSeNEQZSxlKsblJf+/6Fn
	 rxhvCusv/e+HA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxkTh16kxz2y71
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 06:47:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725223638;
	cv=none; b=Ep6MoXTMfKnkBihw8LxS0m6lCCu7SP4z/cC9rXZ4UTlPS9Wfeok19InawUaiylQrpHNmZ2jd3ymsYO6KmUcUXZRrW0iRC+jeaeifxvqvZU3+mjSj+yby/Y2vE1Gr2TI+ceTCZeqXYOokmCqEixlcJ9gPmnWTI355wNjdxIdRjSPlWVV97WFpt51Is01LoR5DvPdoaEvNC1d12dC9gmbeGj0+J3XzrYWvngwRJd/s3PV4DLzOh8owb2s2zISZowYMjdWAX4mRSsvXVCMGa8Y2Vodw2FJAs7ET1Si4l/qUltReK8qrSDPJw4/RW4GP/V+AiEtBJOcfJuMghZWv/9sJow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725223638; c=relaxed/relaxed;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=OZbIYwkAwLzz54irCizXvjePmIviqMAhz6LzZrDx6tR/lTenyDz1FSu0Hctecy2mh5X7MPp/fk3gSh7gYluvReFQNPkXB1znKpLxjT62Z4FuGcZ/VwrYzO3NIozpry5VWjIlX78KzXgRom9wPmWKJ4saI01eRbj6LXrD8RMXNydi0UIV3v5AcBWh9vLUYz9rZnjtllJSwCW834bDY1pwQ9dpeKb9K/Z4fhXEZvr41AMNncXfGg3GF98g5Mkppt0RKQsVRQS5Ofa/Dgqjx/PfmkR8dbfYNi9Rw7IqY0fGRYplP/6kYC4ds3djbKJH/ReD5+jreSDDwLHAR0iDpfuobQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=yxdf/sLw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=yxdf/sLw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxkTf38VRz2xsG
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 06:47:18 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-71430e7eaf8so2867406b3a.1
        for <linux-erofs@lists.ozlabs.org>; Sun, 01 Sep 2024 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725223636; x=1725828436; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=yxdf/sLwwZ31PkXmC3gqcHo1uxnQPcBxM8SC+OTVC0nHUEqLhEZrtaqemuNZCTAxFW
         Q9DOfe2RkFqLd8COpXFqXkmsPkYzeOEQjfPR2ToQo2rTxtV6t45CKCfUclRJIBV6/t7H
         Cor6rIs8fgsB/KH2cyFO8LLheiqHSYVCf1AfsWr4Fbw82R4xlk8AYy2hRt4M8t3AXkS4
         yTWpsKI6vmwQkjHVjsvHpu5hIyBHK77ox+87mLVH/kRPTziOx8XJe48XnHPw22ZgstUe
         8Eub85vBv9xhQQpnravBZtnR1CLqBEEOsiL3ch3PGznQcNL+O8yeLm90/Tyh7zBIbmfu
         1qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725223636; x=1725828436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=wozhCaxSY8ETdfmJlkz5T+6vzrwOFktsTW5zatvJAhsIMMSA7oJiGv91SKGRUEV1Yi
         Z/TqjtWzhnYlIGZ3v28UU5W5BnuBtUqxjbFhsoVFr7ZrzEraJjQe4bwD8iO4T1HvF7Rm
         fgKzSFyOuHF9ebhlTWCH37iLIxdiiDdI63sA3m4Jhzx7jjTWsnxoRyUDODOEuT1AjexK
         HX9RcBaKiDWgJpo/VZT2X3QmCnMNLnK+Bx+OMqHSJg4xmSDh0oOK/qKTjNF/gnqYyBGu
         xTZ8tQAhPqlPKunPklvqMG2vmM5h5VeW9tjt4OXaNLJ3jDSJxTxmlmB475DL6DZOFFpq
         sQww==
X-Gm-Message-State: AOJu0Yy9tUqnGLGvFiSiK28a698D7jJDj7BFrI4qJueibIWXo6CJPm13
	wB8p/2v+e/JpaZKVBIP8DKmHxigNgfmw0c1MHCAp/mYq+dQJXrFEIEOTQavOPYWRt0lIvW30jgu
	EM/2E0ZqXxiUogSQd4Ckbofy6e9HPT38nVd1ubU80mFx/6egVaQXC
X-Google-Smtp-Source: AGHT+IFjcGNusl9VTsJCWzBO9oBjystoboVVMqRnULnORkuw4JG3A7lNAfOd5mI0XQ5MNolRI3IQ7m7HJGFxj8kVpMc=
X-Received: by 2002:a17:902:ebc5:b0:205:43cd:8905 with SMTP id
 d9443c01a7336-20543cd8df6mr43061345ad.62.1725223635333; Sun, 01 Sep 2024
 13:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-2-hsiangkao@linux.alibaba.com> <CAB=BE-SeOSTyScFMztwT-25u5ZEU_kMjbCBYhQES2NN4nAwb4Q@mail.gmail.com>
 <063f290b-be98-4dbc-8e44-1de5b0722f42@linux.alibaba.com>
In-Reply-To: <063f290b-be98-4dbc-8e44-1de5b0722f42@linux.alibaba.com>
Date: Sun, 1 Sep 2024 13:47:03 -0700
Message-ID: <CAB=BE-QGjb_=VgrTkXABO6M3B04bdaQS=NCQnmp1kMy5qYArnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] erofs: support unencoded inodes for fileio
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
