Return-Path: <linux-erofs+bounces-1030-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40855B56DFE
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Sep 2025 03:50:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQ7K253l8z2xQ4;
	Mon, 15 Sep 2025 11:50:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757901030;
	cv=none; b=K/Cgzew6ykX7rpEU+wbJpEI0RQ9yJPmA2ntv57+ll+gqmvaXKT3at7oXWtRthqeM+ME8mpYZjH5ICLpXxMseOyI6lbr5454Z0paGG+JLx7UtSJlXKnPpWjsU6lNV3ictXh4w41TKPUJap4Wsq8YFw5pFVmFcLfZsBvCrcUQ3y3a4xJpuZ/RVR0+jV3cpXQ+M5mDUx/Fh8koI+zKvKhI1/w8rTNjnyeVvaDXvfwZBu02OHRQw4K/TrjimDkFawHvNnFaxyl9H4mhoRq3eN6K8fOEwiAXh7nQMkglKY6YR0EXi3Z8suQjBqE86mnAyjqFWwnCmokJm8PeHscDim2hzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757901030; c=relaxed/relaxed;
	bh=hVsLpy2DxGJHytnh67g78Eu3y7qbCDj5ypXdL3sxugw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMpHq+Z8J5j7T89J+B3JNGAY1JFHxduu3rlcik06XUel2uYwFdRAN4xVFiT5Tv14jjw7Tv/QAE3a2rZjL3p8SSyNMBfh6Npqn9Yq/eZ4JoF3USudfBDFfV5WaJ757ftFPqYtSh4rIcyp9uTuSXb67jKincTJVyYCZlmJ3lzY19RPdvhS9YzkGAgp4y+oPojYta9NbtltWZMcADnV9WGusLVmnDqvwFm9XZenDtDrG0QTLD4lxIcVcj1tgX3cuDBVc/+vKOgj+FKtjK/kfA4rh3qOW4UkLtIHk3yeOGlWaeWZ/uvvIoY4TL1yrYVZAforVzsZuyqd9YOKxc/oVzki3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OY0kHpU6; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OY0kHpU6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQ7K05JJZz30QJ
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 Sep 2025 11:50:26 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757901022; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hVsLpy2DxGJHytnh67g78Eu3y7qbCDj5ypXdL3sxugw=;
	b=OY0kHpU6sGmZzo8mM+5tiZiGQOhJmpoOxx2P21Z9dahvR7vQib5xY7PQK6vk2d/ZO9hAE8eEdaRnlxfiFU/RN7Qg2QqivL5CYYZOGsODrL7b1X5MrtfEOrva4T/ahFwLtYvdw6aOUNYO3K7UGj9BQmpmvcVEceu3RcbrLEg/ODA=
Received: from 30.221.131.231(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wnwp8vk_1757901020 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Sep 2025 09:50:20 +0800
Message-ID: <1998d562-d40e-44d0-9cd9-42e734de67f1@linux.alibaba.com>
Date: Mon, 15 Sep 2025 09:50:20 +0800
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
Subject: Re: [PATCH v1 2/2] oci: replace layer index with layer digest
To: ChengyuZhu6 <hudson@cyzhu.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, Chengyu Zhu <hudsonzhu@tencent.com>
References: <20250913082748.88070-1-hudson@cyzhu.com>
 <20250913082748.88070-3-hudson@cyzhu.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250913082748.88070-3-hudson@cyzhu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chengyu,

On 2025/9/13 16:27, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> Replace numeric layer_index with layer_digest string for more precise
> and reliable OCI layer identification. This change affects both mkfs.erofs
> and mount.erofs tools.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>

Could we have a way to support both layer index and digest?

For users using `mkfs.erofs` or `mount.erofs` directly, I think
they feel more convenient to use layer index instead.

But for snapshotter and failover cases, I think layer digest is
more suitable.

Thanks,
Gao Xiang

