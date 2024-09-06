Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE82D96F95B
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 18:31:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725640296;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cBrDozFDHhFjRuES49E3nSSfH5N8yPCsUbK2lPzuWFgKLYyvimVGhbXWVSjMSIHfD
	 9klgsCag3VUM6yjs4IVK/Fe/aH/A4HMTgsWfWKx4mjc73VgWkmDeDLBtm3Qd1i9zIa
	 PVf1G28L2vaLSmYOkfRfVKjBKM2+Z3jOU/obLgyVLWz0P0ITvng/3dtMCKtukpwjqg
	 KKR/gY2TD/81JqnblGJOzzicgMjTVqYnaMvlu7dSO+I/DqMCmSPZccOTrryFO0ZaUF
	 sJVwmn5hwbn1fGkzeX2wFRQ5/un5gSOc9paHU3qO1Bgv6Sh9oODtoO5M1X1kWGDowF
	 EseotQYA440Jg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0hZJ0k2Nz2ytJ
	for <lists+linux-erofs@lfdr.de>; Sat,  7 Sep 2024 02:31:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725640290;
	cv=none; b=T/IGj7MUqL/JWKZloUsdtDSfDm0GYpsh7OwseSsa1vVLBvQf8nat9DwetCtRWG8GvMZ8FQmaHDqk5pezzx00dmIdd3Fsh0gyBgGiIn4pZ4jsRv0ew4vvsasuxNqpv/mM5SOOBvs3Bww7cWwLRs3mwsg98wNEQnQu/JVC2htMqcVNPkek0BbXB8Qw//2nznoVrv0heXWldCwQwhjBXs6v8iDKgd5j1pGuKmZiomXTiomcTUdaYtoQTdf8VPCzq2C3D6wdC5TBuDnRy7klTKc9IZpq3RsfFPf+tYDIuqzLTZX0uDCz8XOsrU0EZcONxo/97l4zTK0ghLteL3buNcey7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725640290; c=relaxed/relaxed;
	bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
	h=DKIM-Signature:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type; b=LFegBPpsKxji9Nj8o6fcXl/1LDYeWz/MoU6v5xyWr9cJuxauSOEh6UJevnyRy08y7M5sQFimp7KJw7R5U1A4OTICdscE+B4f9kKqiMCiW2jGKowPl9AMr4tT65OJJCuvO0umTgoyLoRQQzjuobHN30Rrs0R2jUJU/KeoLGcPQLKz8mtgq0+R+Z0PmvR/KElPNPYtDCLsdg6hPkPb9JHMS75rDoVD0aM8D8vXTRYiIbIA4Pma/e5BoCgoizj+HEmDr2r6272AcWUL2lONgz5sxKHhJlxbGPpVqawPWlcUpwRjiYCkF/f6L58tv3Nf8AsxIKnQ6FXsgTJI73lwCN6wOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=vsOCJ0wT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=vsOCJ0wT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0hZB16YQz2ytJ
	for <linux-erofs@lists.ozlabs.org>; Sat,  7 Sep 2024 02:31:28 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-20543fdb7acso17901835ad.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 06 Sep 2024 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725640284; x=1726245084; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=vsOCJ0wTLJB/tU4JxbMIQ9BJXQYIGGIruXXgQBy/ITTApM9Qmxs+RXSYm4wCaUcq2w
         S3JtPX4KuMPKAlXVrD2VpZ9YUZSy2vpnRnWXDPstPvI0OZFMpzvphVO865CnPRQeyWYz
         7bOsp2GTabNUOUG0MNrRIX9SB6IRJ554s2zzOrgSNrL4sYUHH/3t/pTZeSVT7PInXXrV
         MIx/PxoLnySIBlUBbXg3SYrK8GJ8iw3ejShVEwEE48Tb+CzsaGjSCDCsvDyHBwZ5/U/k
         f2Lr5HyWz5aBQlVUAYlZ2YVKR4BJvdzdTmJyUbjrTJc8Ba7BDSAufaqGp8mV+DJVvFDh
         5Ofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725640284; x=1726245084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7342bL6XlId672ZUmqVGLoIQV+uvAdMIHD0PWaxvgpM=;
        b=n0Dq32nqtQSfJTHfS40odt2bjgDPyco+gHNRD7GZO8slJxpUZsrIqm77RVAvZ3tocb
         AaR2tMPSDnT1Prt6zMGsYyYJjujuIwbQaiNW5RIYvdXuZbz7VwLb+VjKeVcM6KVcr1wU
         Z/wvzBxtJXK3bhtuDo9HpqVFTY8/fUQd6EgwJc5+weFvFMaA35+e3X4/DDzUsq8MrePe
         o7pgNzy8nRqD0fuj8VIHigLeWdP80ONCZmRaSzZWSrsK682z9dowzAi0idKkZv+jPckj
         E5VLeLXmvfPCVoxRRuPQNCt8+VvJM4psdTUK9vCPtpTlFnURmv2I2pCQ3ZujwQYjbwMl
         gRVw==
X-Gm-Message-State: AOJu0YyADFGCw7a+5YcKcUP9VirrOZlhSr/gvHiBb7snOuPnGOVnriNb
	pPl52agbLQ+KIi6VMm/4r3mqxBbJbyIJURwHmtgUiOLfIEokuddSVeh0DK64aS9VRgRtGBeTWjh
	IzdQwy4xpRUD7H7xV1kYnFO/u/fEPibzPDPNL
X-Google-Smtp-Source: AGHT+IE+LEWAj9/g4Is3MmlTpIUtXSaMHgWlfCLWUHgtqJSCV1yDe1kIGXDkMVF4nmCxRIiwbSwo7niYC7GURXqrp+Q=
X-Received: by 2002:a17:903:32c2:b0:205:6f40:221c with SMTP id
 d9443c01a7336-206f05404bcmr31343135ad.35.1725640284062; Fri, 06 Sep 2024
 09:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240906083651.341555-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240906083651.341555-1-hsiangkao@linux.alibaba.com>
Date: Fri, 6 Sep 2024 09:31:12 -0700
Message-ID: <CAB=BE-SkPOgr-x0M6HKfmGk4sfK35Zdw=CS4zGFMFaBoPDzRxQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: mkfs: fix an undefined behavior of memcpy
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
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
