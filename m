Return-Path: <linux-erofs+bounces-1589-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4788CDBA74
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 09:19:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dblCw2BwJz2yFd;
	Wed, 24 Dec 2025 19:19:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766564380;
	cv=none; b=MdKAPx9PmG7IxFD5lhzRn64I2eQNxfYVeHOLjll7zNZ4eYx9GzqKBfEX2Cm1AMOZ+ApokjLiD07Z5SnR6FqF0n1bBFU7T0nIQOQlRYorVRfEhD+CJpcYgwM/eZGyn6IukOySgS4EoGIpvZ3KcViBtjaJd0Vy565DSZjOHQT6pa4Pr2HmcZjGvDS5OpLIKqzkwqT5IpekW83rYd/SsN+JGrDTckNNh3mdqlJ1nmGw6mAzlYNIvdnReQ5n5TrLtJHmmiXlaxFiLjZwD5AK/uIYHzxxCfTXDSuQaP1I7s6nmMC55Q4/x1t48c+bLPaegDuDkyqyJWb7LP/V2Xs5C98gfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766564380; c=relaxed/relaxed;
	bh=Poea4D6ZtkRk1wYWsUlI3KQOAqqgo7NAY+cTVCqmt8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqmCFkUm703hzDJlSWjpRYingYRQJrN2zYv9BgM3y4ArnYGRFGD9V3Ql4aFwfgJ4rzsjc3cxgRTslDRQdhLIWv8BSpzZUSmhVSJWhPuNAurUSORjdsEKEr0KVxNIi3NCzHDjBpTMwXuxgOMyIb9JF08QxX/fOW5ta69wf35fP/PTWcfQRPWfPVrEd8rsNNzobGi4gAn7luAwATVdIG6HoU/Y7Ay0v4KfZcgSRTqNVqe1bfAO7MzzhNTEklB18F9w+mqS/R6eFv37Gaiu3lyLGGsrZv4Iz4mmaTmOtcQg2mF/zDFf1oBf65RmcODRDSplTG5lKdcRXUsnXq8NNUVUww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nIXDxuzd; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nIXDxuzd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dblCv2XSMz2xqm
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 19:19:38 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766564373; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Poea4D6ZtkRk1wYWsUlI3KQOAqqgo7NAY+cTVCqmt8M=;
	b=nIXDxuzdRAaPHB0ZH96/+tjoYpAIi4YLM2g6XLnrRSQGOybnl4EJQwmKfWdDmwY8LaqQ90dStsFOqzmIPdrlOSWDsL9WjKUtKhmCPG0befEXmvS5spd12sRZ2awjIKT10dVw8Cj+1qlc8rgFKhc5LIgcGweoApOu3gQJ/KLgDhU=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvaV2jt_1766564372 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 16:19:33 +0800
Message-ID: <ce214bc3-4f11-4f07-a52d-bbe5ac385a07@linux.alibaba.com>
Date: Wed, 24 Dec 2025 16:19:32 +0800
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
Subject: Re: [PATCH v11 10/10] erofs: implement .fadvise for page cache share
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-11-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251224040932.496478-11-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/24 12:09, Hongbo Li wrote:
> From: Hongzhen Luo <hongzhen@linux.alibaba.com>
> 
> This patch implements the .fadvise interface for page cache share.
> Similar to overlayfs, it drops those clean, unused pages through
> vfs_fadvise().
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

