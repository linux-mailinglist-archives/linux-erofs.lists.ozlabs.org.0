Return-Path: <linux-erofs+bounces-879-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6673B313B0
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Aug 2025 11:44:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c7ZyW2YVZz3cZ9;
	Fri, 22 Aug 2025 19:44:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755855843;
	cv=none; b=WmT7bEjl5wTnMn8p7gVnEmakRfhZ1YQtX1H1RxJoshUCj+wz2Matpyz96wAFSemEp9fIxWnBm9ZmZWaKFczSHGu3pc9mLccmzd5KbuZIgnOmsivzBrvsihcgwBVsgGXDX/PtzxJB/Wq5oZUdwLQcKWT4Xm2UYsJ9xWCqR0jGehNpDEW0prMK1+IXhwmaVXAQmQOwAWGLSSIkSDIt72TxVAD3c9fHIqB9hdu+6DsQfnFCryuXTcYsSsw+tRhbO9d3FSiOV2tYo2z/vnxAvizKwjmQCgQuKEzn0EuW3gHJdbypmlNO/5+ngFKFM9wJFIeF2gzp8VqKMmzi2Mf5zJdx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755855843; c=relaxed/relaxed;
	bh=QD6wrE9wlNNOzcW2mkq1qoalhj0ZKaFCn6+MYjis0KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRZ8LXXEzXPVp+TFJ9+yWRt5z6aFdG4DYRmYJ5LxgsY+jtYjZt21yCB+9jSlqoQgoEcYfWOyHNJfp6jw6UaFIa1ndlwVEO4JAl1Zz1KDiOPw4dREWlK3//1OP21oq4rqznW0aT6UQPQiWT63qz0MNIiN82XWv4TFPGaw41wkEW/By41MjEnYZnokGrhJ4INDoJ1y6SeJrNzxo3EmI/CqBks54uvJLJV0inDgwHdVXmhK5jf1BrrVVy0r0O+GdGnvRbLMAhcCrD0Fd4erdffKKyOIg/TPBk4d9chAl9EaYjHylX2vtN4+8j/++6JlZ9qizLNpJRM4FilrZNR4Dpjxvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GwRH8uHF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GwRH8uHF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c7ZyT4W7Wz3cZ8
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Aug 2025 19:44:01 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755855837; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QD6wrE9wlNNOzcW2mkq1qoalhj0ZKaFCn6+MYjis0KM=;
	b=GwRH8uHFsZXDEQrH2JYFxXwRTxCv38gIgOj3NilYIZxi/BkdTOwgavz/qzRd0aOekL/c1l92ku523DoJiYibaWJa5RJ1IOUEr2yVorgRlCueYve0wsYhJ2mYE3Fx3H4ZCHkbMuqfyVe5p6kvNXoLq0zBVfPf2jQcM5KGGDSxj8Q=
Received: from 30.221.131.67(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WmJK3Fe_1755855835 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 17:43:56 +0800
Message-ID: <1346a6a9-d6b9-4396-af4c-276ab71379e9@linux.alibaba.com>
Date: Fri, 22 Aug 2025 17:43:55 +0800
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
Subject: Re: [PATCH v2] erofs-utils: mkfs: Implement 'dsunit' alignment on
 blobdev
To: "Friendy.Su@sony.com" <Friendy.Su@sony.com>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
 "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
References: <20250822084241.170054-1-friendy.su@sony.com>
 <ab8c4834-a2f4-4b04-a797-5fb3ab3f9e40@linux.alibaba.com>
 <TY0PR04MB6191308433B54530F009868EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <TY0PR04MB61910BB1A38FE11C4F80B0C2FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <fa5a72ad-8e69-4ecf-9b65-de91f2384289@linux.alibaba.com>
 <TY0PR04MB61912BD4A4596D2CFD485B5EFD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
 <7b82b184-65fd-4135-b9dc-e54c4b3adf95@linux.alibaba.com>
 <TY0PR04MB619155A336D9DF4FDD0D4218FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <TY0PR04MB619155A336D9DF4FDD0D4218FD3DA@TY0PR04MB6191.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/8/22 17:41, Friendy.Su@sony.com wrote:
> Sure, 1st one is deleted, 2nd one should be more completed.
> 
Sounds good.

Thanks,
Gao Xiang

