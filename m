Return-Path: <linux-erofs+bounces-910-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D9B35201
	for <lists+linux-erofs@lfdr.de>; Tue, 26 Aug 2025 05:01:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9srb2N2Lz30Lt;
	Tue, 26 Aug 2025 13:01:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756177311;
	cv=none; b=QAitBxLtur+m8pAB9Kv7vFRSHFYfisnO5dinFBLwhPCe2HIoVBm8Mi5m09xx/t9ATt+mz/qmeSjco/hGD37yv0iwE+uTChLFqfWdEkZC+s5UtMWXFqtFtBHQcYGAt5VZRQ945ORWsfDkxDWT6WG1UQHJedJgw0Rfj6ftG+ptFtZveWWTyo7NFKhqr1bvSOlaXAWLIimag7YWyF3t4lv5fQkXbG4h28TaO5xiaL/n7tvEwq/NsdEzNBixoq5+Mkv4U/OjN4dK0moU7qGys6zmZ6g4ddMcbwc4OkTcrifM3GktimEshzz/4nvcyWItyilQEStnZghAKb1QJ+f+e5cNag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756177311; c=relaxed/relaxed;
	bh=R4tNPCg/I1EihPywaFr8VF3NgXVSE1/obb+3c6rXmAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR48XVl9ZP5iG7hei5AqFqqNDy1TWuX6jt7LuGvi21JUxqLvCWpL8wUZ2d1eEkSy8OgTbmj3vAuQjYTJbvNKtKDwDn2ocKcTQPGUXn7byzeAPtcxhOX0MUeKFMCJLOIJcXCN4LMYSLPwoMyimBY70egfxolmIz4SQQJNNLJGtQPml1XIvlGLZFzy2NPQJeE3sX6fDi7ZCB2THoCW4sMMVGYPtRmpmhOvGrWKZiTDavdeP778gt8xzVRcgoT2ZAJoWiFSE/le5PgDeF/LghKMYNdriaD1PcgZaP3LC6KHXvO6CeVm4etVdBLkRQxfOpUm6YdVb+QNqFX/njYkRN7qvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z7gIlziK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Z7gIlziK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9srY4ZdCz2xK2
	for <linux-erofs@lists.ozlabs.org>; Tue, 26 Aug 2025 13:01:48 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756177305; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=R4tNPCg/I1EihPywaFr8VF3NgXVSE1/obb+3c6rXmAE=;
	b=Z7gIlziKUoeW6rqOKj3kCx+YyrRkxKe9yOw7FVi9GxHcipMGMEgGmM7uwcv4C3LX7nwnNopyPMyLy88OV8KCrNFEsTurK8W7zOyP0oaY+Sk7BnnZIl1NDRckQwuXC3/ePQ7dnDZGbaOR0W9tLNJgDywvaIhGChxlmHYBNI1u/Gw=
Received: from 30.221.130.211(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wmc6U1m_1756177302 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Aug 2025 11:01:43 +0800
Message-ID: <64c0080f-f9b9-4744-b88c-aad7d9ce53aa@linux.alibaba.com>
Date: Tue, 26 Aug 2025 11:01:42 +0800
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
Subject: Re: [PATCH v1] erofs-utils: add my email address to .mailmap
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250825094522.17754-1-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250825094522.17754-1-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/25 17:45, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> add my email address to .mailmap
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>

Thanks, applied.

Thanks,
Gao Xiang

