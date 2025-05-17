Return-Path: <linux-erofs+bounces-340-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9995CABAA6F
	for <lists+linux-erofs@lfdr.de>; Sat, 17 May 2025 15:38:30 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b04ll3n2fz2xlL;
	Sat, 17 May 2025 23:38:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747489107;
	cv=none; b=a40O7/wbvkXWScjCrHOOKhbEL9ZHba4VRuQF4nI+DxX1hNxQLBjcu3x8gYCJqNK7JuhHbChk/IKiRfOMoMEE9Jh7NzR/2o0Rt8m3hrP1eDp5zaTog44gvflotlJFAFbeQLpvdofmst+58Gkbikhb7aGPluDZujXSn901GIZb05WbfiYLl6GGKKn+lXJIDB3pXvcifE/8SFzuvMSX0pqi0iOZOu5zBPmLE4rSG7yiF6+NABRYyr02yQiwbsVeTfG+bYZnT7ZXgmuIvOEu+r2thQARo3eqFPLluWM2CzTHMViObcy+Nuer//op4JDKQVIsNjDnKHK8oxfePbPW0KHzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747489107; c=relaxed/relaxed;
	bh=/2y3CHuCm+oK+QhgXbMXa3N87TqXV+DMGRTukA22Eto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQMyJK0dhUHp6ygOZX5gMIrDWn8H48SmavkbDO/4cXccMR0EUG1l6seRengU/JOPeXEYRzrkFGFTWF6IdX8dpjrJHxckMsfBgHYucoJRiOQMoBjQy+WHyTburhkEiX6WfoicsemEE69Y470GV3IHqK8wj2h3BNJ9EEeaCL5pJbxTyA6zgKVSVdWHJ8466JMZfRmWxeuRvYtuKSUEwwMLG7XUxEQgpO5z29kToZRObxnLRJB71RPVmp1Bbm3lBxR2jUmhjqqnNgCi1gQh/BBBJSv9+2vdalcoV7u8GwP6NZyKeoXZ1bJRi7XaTC7b1h1Ru85zLvvob3es3GUXI+NpqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yKJNOZzO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yKJNOZzO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b04lj3mHbz2xS2
	for <linux-erofs@lists.ozlabs.org>; Sat, 17 May 2025 23:38:23 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747489098; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/2y3CHuCm+oK+QhgXbMXa3N87TqXV+DMGRTukA22Eto=;
	b=yKJNOZzOvxt8rnGkhBiQz63r0VM5GAin/0G3GMu7p5odcncIiTaKlsjt02/cmSlGOuC6/sj67nSPuxlouRiH3KlKOosFh0BXbnrgmB805GLqVYK1Ln1D7+4+Hkh/bErRxqBgTBnkyV2o4EWsNnBDumWZ5MD4aRFORB/4B0/BZCk=
Received: from 30.134.100.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wb-FQtU_1747489084 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 May 2025 21:38:16 +0800
Message-ID: <60a7cad0-a415-41aa-b270-5b218d45d720@linux.alibaba.com>
Date: Sat, 17 May 2025 21:38:02 +0800
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
Subject: Re: [PATCH v7] erofs: add 'fsoffset' mount option to specify
 filesystem offset
To: Sheng Yong <shengyong2021@gmail.com>, xiang@kernel.org, chao@kernel.org,
 zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 lihongbo22@huawei.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sheng Yong <shengyong1@xiaomi.com>, Wang Shuai <wangshuai12@xiaomi.com>
References: <20250517090544.2687651-1-shengyong1@xiaomi.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250517090544.2687651-1-shengyong1@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/5/17 17:05, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> When attempting to use an archive file, such as APEX on android,
> as a file-backed mount source, it fails because EROFS image within
> the archive file does not start at offset 0. As a result, a loop
> or a dm device is still needed to attach the image file at an
> appropriate offset first. Similarly, if an EROFS image within a
> block device does not start at offset 0, it cannot be mounted
> directly either.
> 
> To address this issue, this patch adds a new mount option `fsoffset=x'
> to accept a start offset for the primary device. The offset should be
> aligned to the block size. EROFS will add this offset before performing
> read requests.
> 
> Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
> Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

