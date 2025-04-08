Return-Path: <linux-erofs+bounces-164-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 93193A806F6
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 14:33:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZX58D1qPhz306l;
	Tue,  8 Apr 2025 22:33:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744115580;
	cv=none; b=km8o5gkCCu86dQJwBROO/jHK8UOXj6g0o3TXUP3+IDC3scbHKHz6O1xFMHtcTNzjlWcOvTb7Q3qeJ8ioo3+KrrDOzgtHj8+uLo6AZl/FcrdHZpRIkxh2hB6VRoGnzsLCtRwvGZ1muRGgFyJdjvSNJ7kNBEV+lYQ9RGFwuU5TlLSL+VswSHspfAHGfV96TQjDWiWT+ibsh0wGF5htkLCrhbZYrx4mZNIfSSbAV/jZvl7C0Z3ACNi1W9XWn5OJqwvchy7reClLy5huAS+Qh76kv/hGtWjZ/XwU9CWjorVXb/GDWpp9NiEQP4QNQdQJpI/w2f0ZyrGVRkaAcO/iZRyJDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744115580; c=relaxed/relaxed;
	bh=M9dVXERWK7r6fVWnBHBSPiIvrOmFU75ldecNYqrlthU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ig8Mgt9RzGGSxvWfkvuOvlvOgcS/n+hlAUkw2j/XzAioGq39Tk4/W+IMrgmEZhlsABNFCtnT42AuEiW99OC6b4u49AD61qALHJnsiH5Zsnv4NqI1uW9cX/KeFS0+BPTIroa8MIcsVa5mZeMtRmf/sTXIsCKdsTpii+VDbiAOts+jDXnStFxG+TtZg4FRoeByxKMiv6pYxefb3as+QAg+3fCVupnnwQAIrNVMPBK0lb2qcyItIeEIUhdvPi7D0UUhCFXDts3HrEJyu4R0aVy5sZNU8BnMg+cklJTzJI7U0poI1fbtZ1XhoZ6Xm8Hph8Dd00wGdIJanyzvbrnqWZUNuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SWyI/a1c; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SWyI/a1c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZX58929Wgz301v
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 22:32:55 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744115572; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=M9dVXERWK7r6fVWnBHBSPiIvrOmFU75ldecNYqrlthU=;
	b=SWyI/a1ctW8dwYFA+z17GUGNz95mS+uZZQXp3YOguVbNKHZFFdmPPsod1Yx7sdNa5DOtndOVXDnBosvvCYGaJAIiNKunu5/6Nn/pAyS9g7oh2JCUVpjErpbeqcEYKwlOUAkcVK8nEI0vp4f+Erot30x4pSA6WvyNdJ2CuGMYQZo=
Received: from 30.74.129.179(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWFLMed_1744115569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 20:32:50 +0800
Message-ID: <13998eca-c78e-416e-bf8a-5918618514bc@linux.alibaba.com>
Date: Tue, 8 Apr 2025 20:32:49 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] erofs: set error to bio if file-backed IO fails
To: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 kzak@redhat.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wangshuai12@xiaomi.com, Sheng Yong <shengyong1@xiaomi.com>
References: <20250408122351.2104507-1-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250408122351.2104507-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Yong,

On 2025/4/8 20:23, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> If a file-backed IO fails before submitting the bio to the lower
> filesystem, an error is returned, but the bio->bi_status is not
> marked as an error. However, the error information should be passed
> to the end_io handler. Otherwise, the IO request will be treated as
> successful.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

I will take this patch for this cycle soon, thanks!

Thanks,
Gao Xiang

