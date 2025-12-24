Return-Path: <linux-erofs+bounces-1591-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2953DCDBE46
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 11:05:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbnYt6dpLz2yFp;
	Wed, 24 Dec 2025 21:05:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766570722;
	cv=none; b=gSJiRtn6aND7gpsjnHs/eNxHaFxn1cMJzldG7xMnfo69YUie+/G0nq+vGLwOeefba/maECVXV7FYIS2W47VwlJewQxk/hCPxqyXK/PqzFBFADq232BUPR541fgWptTfH5iOxd06ZVbSvFE/pt4U6XK873Z0DocwnSccBrJaTInWjNBs9deqYu8p5sLVtNfP6HF5hn7YjUo0INhEcBh/J7fas7rGqiknRW57HeFn77nGz3nMmGngsRI+KgNR5ZlyCxxVW2eRG70vlV0LEyCJ9/D88AwELI9r+dzTR42zOhheIIlE/fru+JQ0/5KjWFFI4ngTlILHKYiYV7N6m7jZjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766570722; c=relaxed/relaxed;
	bh=XjvaNCV6Fp280Tqzr2xLCA4/k9qavfxoZEOqMUBS/KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6H50g4d2Qrk0ea18o+JJ2LN4MA8K0mSucy/O+lD6MnyxfETOfPeBCF4+q1kEUvq/HuoHTtoEIUWxNaC4BkjiBYxi53w1wcJK4iqD5dH9DQZUlRwqFKXogixRuIxXIC2SySYrsfcb63WuIlkWgfJ8UefszhG0IOPz4T1tvCJnU8RIyAnDtgGV5U7VvCYIN6YVtP6i6/lL2n9JclUADuhadMDjAiUCBopMKwlEMIS74RkGkhLTj+YwgCwZCq3KV9GiX1YS6IROeuvVJZjjxggFdz2/RXSfCdp1sDBq6bXvgTXL4iqKiLigltd0Dho/G4mT48RrWdCCxWnvs73Xy0LQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dOpnCXWW; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dOpnCXWW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbnYr2H0vz2yFd
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Dec 2025 21:05:18 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766570713; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XjvaNCV6Fp280Tqzr2xLCA4/k9qavfxoZEOqMUBS/KM=;
	b=dOpnCXWWC0r6LXU/qSHYR60uADo1l8OaHeRL2YLqjI/7rMHz0jMtq+saNBkJ2WzkmO50U2+2paoKvX1H2I8nlFrDJtEm7hbyx4dnI1ZKvBPWLvHPqOXrAV4xoI5Tafc4kIrqisorYHD7otgFNx1lK0I2Tu7rTNDWFXKnt+/xRmU=
Received: from 30.221.133.159(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvard6C_1766570711 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Dec 2025 18:05:12 +0800
Message-ID: <84328aa9-5b84-4433-83ce-7147c100f5d2@linux.alibaba.com>
Date: Wed, 24 Dec 2025 18:05:11 +0800
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
Subject: Re: [PATCH v11 07/10] erofs: introduce the page cache share feature
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>,
 Christian Brauner <brauner@kernel.org>, "Darrick J. Wong"
 <djwong@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251224040932.496478-1-lihongbo22@huawei.com>
 <20251224040932.496478-8-lihongbo22@huawei.com>
 <64b03916-7b57-4719-bb2c-8f15ae333330@linux.alibaba.com>
 <5aad8772-458d-4040-a8b6-feff924c1d30@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5aad8772-458d-4040-a8b6-feff924c1d30@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/24 17:26, Hongbo Li wrote:
> 
> Hi, Xiang
> On 2025/12/24 16:09, Gao Xiang wrote:
>>

...

>>
>> why return `struct erofs_inode_fingerprint` instead of:
>>
>> int erofs_xattr_get_ishare_fp(struct erofs_inode_fingerprint *fp,
>>                    struct inode *inode, const char *domain_id)
>>
>> instead?
>>
> 
> How about declaring this as void erofs_xattr_fill_ishare_fp(struct erofs_inode_fingerprint *fp, struct inode *inode, const char *domain_id)? Because the return value seems useless.

I still perfer to return different values for this helper
even the final user doesn't use this.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo

