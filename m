Return-Path: <linux-erofs+bounces-1649-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 69207CE8962
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Dec 2025 03:41:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgHR573Npz2yF1;
	Tue, 30 Dec 2025 13:41:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767062497;
	cv=none; b=mJdq19b+yypymGXPVtngqbwLNWggzP0QncUTAL/Ks3fZJ07InjmGC6Qzctq9+z39FyYAYCMnIg0B9I1qPYQGVxk4TrfNqGgq0Q1y3P8GoLW1WiYn35vy5w8Q4eAzrAxPkhEwiOiehGswoobAttf1gK2D4LzNp1I2UAxiThkOUXu8k0XP3pJC0WG4LEU6ZooDq53875bMg9BasDqo7crfmma8IoghModCvcd/SsfYGvoFQmFDzwHBueX57LdaYXWqB1UcSFwQx8IuJogp9Uk6e/uEVqIFdCN8oASacROyiJAYZcXrRM4GWJ9FIE1DwwjIaKwBHf3PNn+cJlcnQBMa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767062497; c=relaxed/relaxed;
	bh=BHECXuf7BGGK6HIH3OcvjKNNcItho0HqYMLKFuwR6r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVXsvBAu8ksu7biNzjHpSkKUf0UL6ZX3Lnf84s1Ak4013tIvmRrg6cP5LOP1dVlWEuN0rW/53cFVrvjkpxOonvdtFaFJ2Tz8nfir8pMMT+LudegRF0R57+M4hj69+0/4q1HfLkmJQNZVIcX9Kd1XNNXabYLHFl8HPWbEXkVQQhufdnNu70NzcGlMlabc15WR5pujTACh9GZSYSDD/5BtCc1SE7MN84k5a+j2p3P2ZnuVwl9YkUnxwsG3T7MSQ9cTrd8+GfD9MNNV7F4wwNDNuxM9SkcQyNYxJPILjAC8LDv53/mdMoU5ThJe6L8JJ3s89FvmdXJ/8zWv8PkvmWxGVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=twTvpm1w; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=twTvpm1w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgHR507czz2yD4
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 13:41:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767062491; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BHECXuf7BGGK6HIH3OcvjKNNcItho0HqYMLKFuwR6r0=;
	b=twTvpm1waIqD8gkb7JdxydqCXpWS2SGCHHrMr3y4fdkuGqNRoValHpq2/Doupyr0xPI8wbWBphKIi7m5uX8bCVviqmkkq2NLHgOY25KUBzVjkfypEar7TZDn7wmAWXEUvy4m1gNrZaI8FTMpjF8bhf4/6bsX4NkceL8VB4QbPzw=
Received: from 30.221.131.96(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvyRcf0_1767062489 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 10:41:30 +0800
Message-ID: <b42ca0d5-9740-47df-98e9-2c2687b00a30@linux.alibaba.com>
Date: Tue, 30 Dec 2025 10:41:29 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: remove useless src in erofs_xattr_copy_to_buffer()
To: Ferry Meng <mengferry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251229100515.111287-1-mengferry@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251229100515.111287-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/29 18:05, Ferry Meng wrote:
> Use it->kaddr directly.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

