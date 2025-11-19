Return-Path: <linux-erofs+bounces-1410-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4BC6CE27
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Nov 2025 07:17:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dBB8v61gjz2xqg;
	Wed, 19 Nov 2025 17:17:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763533039;
	cv=none; b=Lw9DNXrBnLDZPNJVCxXT+obzHGjS4LPH5lFWmZ9+oC5uolhvdN9+A32rl06GXEMhsqNJenIehcgKAPdMAcpXrAknSAuDIvIoO4Clswn9ibaKPGaWUS3AqDKb9wo3cLHDUvIOwHAEjYBdMOuS5jab55EAcW/BwSA27uJAZpUgDbVWmWp9o9OtYWL8pvtJZbCLFtgjvU2UjQjsvT+tL8WAHDUmNV40Wkg6hVanm/aMc7FvxqGceQMxMMA3EoMOS2EPJGXyeiRjwO7W1FNfTxqhjCB4tctIdWH7kuxVAJneLEGwFiEgNngQxuDx4G8HBoEXPfQfEMgJ4InoTjvJymZ+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763533039; c=relaxed/relaxed;
	bh=kJM2+txK39zSBZAW6+j8p6tvdTb3h7gwyHWV6tLX5Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Db7LaJmNw/fq2Onm9J5JeMqDM2hCvW1mInSD1BP3WtM12MEOiC4p0P8SES2hASD8ymH/eHbisN7Z7v7ehHUCRE2D4NJG1HR2V+IongYYb05v+S3PXxpG2V5pySZiiGxaYJ8NBV/JNpAjRbEDrtlV5RxWyMrnMQ1pLueHKU+V1LkV8HrLwcIlMABOQvxNbOrNtl5dh7xKIoIthZTCZLT1C3rn1qdYq/0GCaLGjRY/SjhEh4Vh/nGGng0e76SbDU+igCtnOndrY5gm+fMi9BYWLwgDFQoDwCliAH5rJF2pMoUUCXERdYAgZVFw8PpdrCkYOBmJ3TiEOo6erXb+9dhG/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wUauseDt; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wUauseDt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBB8r5C8qz2xnk
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Nov 2025 17:17:14 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763533030; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kJM2+txK39zSBZAW6+j8p6tvdTb3h7gwyHWV6tLX5Pw=;
	b=wUauseDtKtrHb/nSmXwsF43c7dZAlpstQ4OEj+xT74jgju/duCULtT2Or1/DGc3757vvD1SG519iGgOfB/z0qT1AS9i1VIxPsSnQywW1QxRpPSH5GerimTi2teVkRsUJJgCguXpN2WBcvcHqGKfOfcyJaN3EcRF07s3ZYt9ykLg=
Received: from 30.221.131.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WsnTUov_1763533027 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Nov 2025 14:17:08 +0800
Message-ID: <e572c851-fcbb-4814-b24e-5e0e2e67c732@linux.alibaba.com>
Date: Wed, 19 Nov 2025 14:17:07 +0800
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
Subject: Re: [PATCH v9 01/10] iomap: stash iomap read ctx in the private field
 of iomap_iter
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chao Yu <chao@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
 Joanne Koong <joannelkoong@gmail.com>, Hongbo Li <lihongbo22@huawei.com>
References: <20251117132537.227116-1-lihongbo22@huawei.com>
 <20251117132537.227116-2-lihongbo22@huawei.com>
 <f3938037-1292-470d-aace-e5c620428a1d@linux.alibaba.com>
 <add21bbf-1359-4659-9518-bdb1ef34ea48@linux.alibaba.com>
 <20251119054946.GA20142@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251119054946.GA20142@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Christoph,

On 2025/11/19 13:49, Christoph Hellwig wrote:
> On Tue, Nov 18, 2025 at 03:35:45PM +0800, Gao Xiang wrote:
>> (... try to add Christoph..)
> 
> What are you asking me for?

Sorry about the confusion.

Hongbo didn't Cc you on this thread (I think he just added
recipients according to MAINTAINERS), but I know you played
a key role in iomap development, so I think you should be
in the loop about the iomap change too.

Could you give some comments (maybe review) on this patch
if possible?  My own opinion is that if the first two
patches can be applied in the next cycle (6.19) (I understand
it will be too late for the whole feature into 6.19) , it
would be very helpful to us so at least the vfs iomap branch
won't be coupled anymore if the first two patch can be landed
in advance.

Thanks,
Gao Xiang

