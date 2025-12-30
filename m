Return-Path: <linux-erofs+bounces-1653-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB3CE8AF1
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Dec 2025 05:38:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dgL1W2ddmz2yDk;
	Tue, 30 Dec 2025 15:38:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767069487;
	cv=none; b=b9SCC3moEraPLbUXjTi/QjUSxTLBOQuHVp6f6o56i979L1dEAnI6fjtbTjZrWRaub4odRNW5EPcY/Jc1ox8/HzLhrsBRXRkArsY7c/QpfgO2+4oUpErYUONUQcT4KCE9OH4n1fCe0EtwJClf5bq+MxD7UtJQ7myR/9RWLSnTI8vcBacsxbwBmMqml42xk6c5Z2KY2eMvVGuV4/ELQhW3ArPgEYqJ79D/8Z5Mddt1Mgo4zo5moEb6NsIbonDY7XcJ/ioOt5UapUsFpSZI5QRKtPMYWTnHdJy2j3c+1yzXORfnyc+2I6YjejkmM9BPArEp5297MQLOEXTK35pw2+480g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767069487; c=relaxed/relaxed;
	bh=etCvr0qX7xns3wbhlVYrKvZ4fRu6zZRiHlD0Y3HAX84=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ugoekf2d2pgZIwsyyYZ+O3QThCMDP8R11WDPX3DllQI2ihnkI9Ps16biTQbf2a0dE4WBpD5YAfGk6YJbGdGyE9OBl3jJ3WXExSlHgWYC/Cau0ISTYEH/TQHE3+Ukl+ql5vhBHcu0WMi6ish1kl1eB84LRlhE5ifRglBk+AS6NMvZikIXzgjKOVbZ+EIGKb88XKwFzsOroy4pNF61V6cqCqHI7Ffgc9/qCCp+gqzS1oFLp/pzSyayxxh5TmDx0xXV+UyQ/tlCbR6m4gdRnf7X27KizFhSr+AdLK5AQDy/1UT3uHJTELP013vEbBCZ3LPw1+RVTlvowYaPgHpaUzQz9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gjT8eWuY; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=gjT8eWuY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dgL1R2XFTz2xdV
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Dec 2025 15:37:59 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767069474; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=etCvr0qX7xns3wbhlVYrKvZ4fRu6zZRiHlD0Y3HAX84=;
	b=gjT8eWuYn3hIzUpOAsboDUh15iuL1UlAXXlLbeUKvROFcJETyVO99UiZayrjA1mPYdTSdybfOrxCi1FI8XsR46lTg0dJZVYaQ/S5N5J5KmeIWaDVKWb1dqOUPlan2dnzrjvXJnhWz8mANkiDQ8I8qoBDPPyGAxDrwNd34uDa/V8=
Received: from 30.221.131.96(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvypPu5_1767069473 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Dec 2025 12:37:54 +0800
Message-ID: <f29b1261-f9ac-4b5f-bd43-043baac372e6@linux.alibaba.com>
Date: Tue, 30 Dec 2025 12:37:53 +0800
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
Subject: Re: [PATCH v2 4/4] erofs-utils: mkfs: add `--inode-digest-xattr`
 option
To: Hongbo Li <lihongbo22@huawei.com>, linux-erofs@lists.ozlabs.org
References: <20251229180646.3017326-1-hsiangkao@linux.alibaba.com>
 <20251229180646.3017326-4-hsiangkao@linux.alibaba.com>
 <7c8f3af8-f232-4bb8-b6b6-beeb96aa97be@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7c8f3af8-f232-4bb8-b6b6-beeb96aa97be@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/30 11:44, Hongbo Li wrote:
> 
> 
> On 2025/12/30 2:06, Gao Xiang wrote:
>> Based on the original Hongbo's version [1], it enables storing the
>> SHA-256 digest of each inode as an extended attribute, in preparation
>> for the upcoming page cache sharing feature.
>>
>> Example usage:
>>   $ mkfs.erofs --xattr-inode-digest=trusted.erofs.fingerprint [-zlz4hc] foo.erofs foo/
>>
>> Co-developed-by: Hongbo Li <lihongbo22@huawei.com>
>> [1] https://lore.kernel.org/r/20251118015849.228939-1-lihongbo22@huawei.com
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Maybe the subject should be changed to "erofs-utils: mkfs: add `--xattr-inode-digest` option".

Updated.

> 
> Tested-by: Hongbo Li <lihongbo22@huawei.com>

Thanks!

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo

