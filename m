Return-Path: <linux-erofs+bounces-214-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFCA97B2F
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Apr 2025 01:47:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZhzS83tthz2xxr;
	Wed, 23 Apr 2025 09:47:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745365656;
	cv=none; b=Hu6L1l1LQcgnLVwBkfZnICe1rCZlcTTFpHhFvklkr61BtS3H1+KmUwUXr5dc+2c2RuvWP5ry2MvLmNwfb57ZXpPPS+wDF3TfJtwHxf0YD5WfZJrS6XSnYMARMs426+1jtbU+OFr8t35aqG4kuljIbjYZSb4C/MVW4uZwpL1CQ3IT/1wYVQnstLn5juqrDli1IEJn4CpvTR6KzPtfvHJBE6ZOWuJMuz0gWaETN6oFQkDDatqYZYt4jeLDAMChJEzsMGUyriPMjQVckSkXjelXSRCTeKtxEaRf9N1N35XLX2+ZM71FdXhHFLRiLJV7IaZ2vL32mmMgVDV3FvcykH98zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745365656; c=relaxed/relaxed;
	bh=ukVNh6gkEjNNQE8ZcUfA6z++5Osp3iiUUXbBw5q6QYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3VbeezEluacS/5He6FGRiSWlaYeVeYwwW29yAQY0jY7UYxeJr+q0yrVAEs/nqqOHBErzHLx3ZKuoig6yPxIdSSRXIUDdE5tu5wY2YW6qVw7acAfRfPaatVNKFdHxx6SEVzsp7Gh7FMr3y4X+ws7V6XzgcoDmXdDzVpkw0i1P4OkwcJRCnnx1M8ML2u+fbbC7x9AQmj5aOtUKqQv3za71PKXGmmjYZ7WTqPhrMv2IYs1xknmoXd3ctImkAku2H2l32VAhXzl5ExndI9jnXZNegWxKw07QKJ6OP4dnCb9Y7XoSZ7NbtqhQRfF0kmx1p0TVAMzLy5bzEGRAo2czUI8oQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=RugOsuby; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=RugOsuby;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZhzS74p42z2xGF
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Apr 2025 09:47:35 +1000 (AEST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-ace333d5f7bso166425866b.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745365651; x=1745970451; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ukVNh6gkEjNNQE8ZcUfA6z++5Osp3iiUUXbBw5q6QYU=;
        b=RugOsubyPAzWxJkjcqW2uh9k1dxjGft1HUe2pdJEDfKNdUQ7RlYn7fcnzJClRFHoOY
         +cYxQw5YwMVLnKnvG17TEjNdbrtlL/Ne7wXB2ArhDtoficfHM4jNJRCDbgleB/tQ9Fpi
         bOl3QiJNsQ6hBzrvD/bZt1cveR6yfAHtlyO9XSuq0OG9uPvnakMBtmO2+x+9HiEkfDNx
         E67VIdeWYQo+3/b1RzRKKFZ2L675qmVE0fN2PN3FDxm/zcqFk0AH6lH337r7PBJb4TwL
         YZt/GHRaJEfaOjgCt3hSli6TkLu9QRfyq9bE3RJvcWnVzao/peCfJYZyxWJ8TaN3mzei
         BKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365651; x=1745970451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukVNh6gkEjNNQE8ZcUfA6z++5Osp3iiUUXbBw5q6QYU=;
        b=mQEY711+SoLOPeGgrjQAhcPWA/P11VYQkL1w8FbLNTSeBnD8AP3/Lii7S3ZkiQr8Jh
         dlcGrAzsTHjzHoXQGkRe4BLRcE4mEsFqtnk9mnDitEKfbX9ps270HnATAXafklj0ugiS
         tjH1T36F/h/WPfgeDHvl/yVAmvN5qE8LDMdNnsmt0CAE2oyXQj7hgxyBuZGXGqm0q6hG
         rAmsuRLLQmqwlSNJ3tflyEmhcY+L897q0Y9ZJi0gVut4k8cYXPfz43bEjHTwOus6CuZm
         ry7gOLk7uAkBi9ItKvFV45O53uBRyLsh4p1arX4j4/kK5WLjMSFhp28DVBPEM1A1hUQv
         iOUQ==
X-Gm-Message-State: AOJu0Yz9BCmWSSiImiA+vpUukfPErDy62mwT/Y6gI7W54KXOiNVuE0rX
	4UeNRjU9ehU7v45uwbgsT1fWRoDECcp0hl1HMZ+av6/+5Dxwn3uKmFKPSn19zt4+CnbsSO5Dw6t
	FXnafEpbKL1FH5VeF+7GMVDvC++2UEp6xJ99g
X-Gm-Gg: ASbGncvIrXE4/cxaSW5fiQfhObrAuPz8LK053KJYu1zDReO/kKsrgwIOAGcjyhBVQYP
	e88wGhuczq+knfUlYvgiUlfkV+3fq6UBgdCMzzzr5np/GIz95g7SMzW1nyG8Xbva+W3wqsxcaKH
	R5NcpSL2NWkhSlDtBeV2r9pa3aNnM5rT8kKzEaGRPMZ19aSsviwG4TG5lGVgidzA==
X-Google-Smtp-Source: AGHT+IHWX+cJR4ZByTaG9eqY/XIVp83KudSrONhKwKheK98JSHH08eIxFd1YyKl56X9x/D2Tx9dhhXu8we146gJD6uc=
X-Received: by 2002:a17:907:d1b:b0:acb:34b2:851 with SMTP id
 a640c23a62f3a-acb74dbf387mr1661803466b.44.1745365650881; Tue, 22 Apr 2025
 16:47:30 -0700 (PDT)
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
References: <20250402202728.2157627-1-dhavale@google.com> <a1e86463-3427-4715-a4a2-0ef88cca6135@linux.alibaba.com>
In-Reply-To: <a1e86463-3427-4715-a4a2-0ef88cca6135@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 22 Apr 2025 16:47:18 -0700
X-Gm-Features: ATxdqUGnLf9fwBXIbAT8B_UnhGBc9SGDdMO6_GxwRbOUIVqIOs2m2iQ6Lh6mWGY
Message-ID: <CAB=BE-SbX0XyG42wLwfH69vKfBWXMw2NL9jnJisVviK00S7Vew@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Gao,
Thanks for the review. I have addressed the comments and
did further cleanup in v3 at
https://lore.kernel.org/linux-erofs/20250422234546.2932092-1-dhavale@google.com/

Thanks,
Sandeep.

