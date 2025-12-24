Return-Path: <linux-erofs+bounces-1585-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D3FCDB99D
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 08:35:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbkFP2zszz2xqf;
	Wed, 24 Dec 2025 18:35:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766561753;
	cv=none; b=NLj6CrmmL7u2w66oabMDiNTfuZjTrFn7auNJQQzl/oLfXg86tssA97k7wWRa5G/b0EGbhpQNxq9KYp5ZhuVRMXnlIcBVVIlMIbMRamaHz6LTKJP7rA4cMVYkSVFZOnhxd1K5KRQsiqkif9EhPOZ10RXjLwyt7XZeD0LIJa2V334Jhkk6WVD0y/igF0f5eHXht9d2TrUubNucn0PCO7kgs90AnhKwmvuRNAx5EzcgMMCU4wcLprMN5r4B/hHKvCuRmab9+jHfBMfVk1G+4qtM8VtKEfSYBL46/WDYjy1COPwUjhx3BaE1w/55ZGS85KqYGsOexujGDWqFXZ/64g1m8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766561753; c=relaxed/relaxed;
	bh=EKclLrJzBVisN2PeDLUkiQ9uaIOQq13bMgXD4yQB+wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uv7Gh0b+5GAe66EO3YSRQgdDI8A4Mf8M87mSIcOUNoLVKU7FtWpV+8DKJtodyEtUX9WtfayVAn3Om/bUaD9lqN9LD5O4J3We3Sd14KwJ1MtuPeVrzIsw9DejFYRE9UdtO9d29ptdz5jhgKfVcOEmk9OlrOn40kGKkdF6tzQ+/p/P3gp6ZxxdTeFVJnrytsjLZutpNcSpEyB06deKP+A/IgpmpqeuPHNNiUqtEwXKJJcwA6nWI3E3WF/WtUiB4OPziGyI4rN52tZmIxxDUNKO49Zewn1EKb1IXqjo4vqJuVkcpm84CXzpl5YLxv85CRDN4vUbysH1rVHV9FpY0jbCFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=v0wnQmL0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=v0wnQmL0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbkFM5kbhz2xlM
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 18:35:51 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766561744; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EKclLrJzBVisN2PeDLUkiQ9uaIOQq13bMgXD4yQB+wI=;
	b=v0wnQmL0NEfW3NiuJQQheAdgnV3XqmgVYBrHdSLFQAemH8BAryih6hT1pw42/nT7LfbFOWGOGiFaGJ/BGNAxfihbRt5BraORxCVGgf+1JWJtVsXiXJGbl0g7zBUOGzHgDO3TUDzaDWyaopXAs2F/YypunD0UA68G5ZowZwxlzo0=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvaMJ.1_1766561743 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 15:35:43 +0800
Message-ID: <93700ebd-7bda-42c9-b718-57ad4710e615@linux.alibaba.com>
Date: Wed, 24 Dec 2025 15:35:42 +0800
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
Subject: Re: [PATCH v11 06/10] erofs: support domain-specific page cache share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, amir73il@gmail.com, Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-7-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-7-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/24 12:09, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> Only files in the same domain will share the page cache. Also modify
> the sysfs related content in preparation for the upcoming page cache
> share feature.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

