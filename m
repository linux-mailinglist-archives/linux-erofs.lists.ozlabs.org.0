Return-Path: <linux-erofs+bounces-805-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E1B1E31C
	for <lists+linux-erofs@lfdr.de>; Fri,  8 Aug 2025 09:22:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bywTC1QJnz3cR3;
	Fri,  8 Aug 2025 17:22:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754637727;
	cv=none; b=Ug7hMLIF9Bs6qRjFbVsQLFE5Dud5oCfV+v8YD0lZgbOEoq3YVAlu8zUubwZ06qecP7QHrnvtWlXZ0k6nASYeDpGQf+aXsBh/Y9aO0AEd8JXMMTNaX7NkJQekr+qzzHRiOvuAT6J63QCRi6B1/hZbkHsUbkpsii9DRTFQkOjTWbPdS4YFp3zkMdBpl22Meq4xnk3MyuTJNdrNtOpsT6w5VdUxDVH+tyE9o5MJDL8mHQldqHHOhf/8zLlX7jXfn7fDPZjL5LbrJiVAEV0vUMNHqLbTXTQcpEL3xDqR6IfMwr6gzk1YCy/8TewKKjYEXO/UGfnlejPxvF0V7/qGQTfcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754637727; c=relaxed/relaxed;
	bh=EA5l5BrAUy/TyRKMqLP1cyean16fNfHtIeVAem7O150=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgCMnnv/f+ZCT5IFlSGi9/luvENCIhYuaj0VT4XnfcpZgl+7wMU0WY3lrxa+uV3iRfEFnrUcBD21UKz8cUfzy0QTloTmy4NEXCYXfSOkMwhwXZvZyFusxi4HzxPexbugrvZiXuiEVXmcOJNkkSbHhdA9tMTykrwrMNaLNgw843ODSujeWzkfMjwjlHMWpA0p6/vmYr6EBEIA2piR1NkrRB9hlXE9+5K/1Wbjky5O72d7xZDJ3neYbYmnAPV3uLcWeskRNooG4RbvoyOy7+mZwi9GqNWJKxNPCFKnmKE1qnibnmrptEmReyYF4dPYUFwN/QoiXKsX1UUT55LMLYaz8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gl9Ho0Yt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Gl9Ho0Yt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bywT913Rlz2xcC
	for <linux-erofs@lists.ozlabs.org>; Fri,  8 Aug 2025 17:22:03 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754637719; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EA5l5BrAUy/TyRKMqLP1cyean16fNfHtIeVAem7O150=;
	b=Gl9Ho0Ytszqs1lZJ/VgOZht2J7909QwRzztb3ceJx3fT+du4K3d9CtUyBq0pMcQgo5H0sQetoEz+cd+zJJxJ1SMv3XVK7T1nWZdkEPgmSUx0QoXVGJOeWA/1tpyRv9k4Z1dq2KTvMfVK7Wp16ljoXVCq/YtWxMv6I+gm2mjZcM0=
Received: from 30.221.129.72(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WlGaGnU_1754637715 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Aug 2025 15:21:56 +0800
Message-ID: <6a5fa5af-c42a-4a51-a915-0fb572238b75@linux.alibaba.com>
Date: Fri, 8 Aug 2025 15:21:55 +0800
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
Subject: Re: [PATCH v7 4/4] erofs-utils: mkfs: support EROFS meta-only image
 generation from S3
To: "zhaoyifan (H)" <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: Hongbo Li <lihongbo22@huawei.com>
References: <20250808031508.346771-1-hsiangkao@linux.alibaba.com>
 <20250808031508.346771-4-hsiangkao@linux.alibaba.com>
 <db416c94-af21-4dd6-ac5b-160c6298cb06@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <db416c94-af21-4dd6-ac5b-160c6298cb06@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/8 15:16, zhaoyifan (H) wrote:
> Tested:
> 
> - special filename: 'test%^&hidden.txt'  'test space.txt'  '测试文件.txt'
> 
> - manyfiles (>1000) directory
> 
> - path-style obs backend
> 
> Tested-by: Yifan Zhao <zhaoyifan28@huawei.com>

Thanks, let me merge into -dev now.

Thanks,
Gao Xiang

