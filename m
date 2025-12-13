Return-Path: <linux-erofs+bounces-1493-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A76CBB08B
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Dec 2025 15:46:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dT8KD0xvYz2xZK;
	Sun, 14 Dec 2025 01:46:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765637184;
	cv=none; b=XQkt4ghWSwCltSFYT7yjSfWIkQkHdBDY8I6UI7QTf3SsNfRV2/QiXaW7np67KQ+rWIOpSdM7CFDfdX+b8rSFF4fCHTKxvjjwCuaRZKA/FQKdwkC+wefkjsBeeVjzyf3EY4eS2tEzMLEKOm7C1DSyixdNePrNNgFyUW7CEWOA+tx9AWlao4NIPydJm0uzucIN3RA98Ag4T/rrmaPZ93RwBlJH3IhVUHgZSVnPt+FtfP43u3MOH+OlimGc+6cALMcrG5OJTJdCPfqEahsaUZseej29CIdfSrurWshuutl3cO9jm784Rx/L0RfV+p+XmSFGwPjN19qYn0GlCy+VYXFTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765637184; c=relaxed/relaxed;
	bh=zozyig2HmzbP81g97IRy+3rgIgQqbpbsMbFeTmU9Nqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2Uf42IO/lnBxn+yoWhwEbzT9fqvxRHatYwPaU7vnpitt9j+vxQEFNlS0KGbwf1vulXs+C+g51hM4CuaZRBaUIDZkSJlyFoGYt6FjxeZFUCtmUXQ6Nt4D8rHa36PjrnIbMkgLDIEme8ci2ltZZgewAVT7KDZaW5IlkfXAgxNxSPFS/+eWbszd7pB1ea4lTQM45vABVLMo01myfJz9SiIhnuplDe32qEwN5VZwnVV/XowXbBU0DZu83FhcysS+Ig8l5EC6HeCosgP6GcQxbj9Pfaqb6NKtbuflxYhHKlAFwDE6YSb5G4/qzxLK/nkqcDbMWONu/pc6t6X/wSjkePNjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cM8QqDQn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cM8QqDQn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dT8K91dGGz2x9W
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Dec 2025 01:46:19 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765637168; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zozyig2HmzbP81g97IRy+3rgIgQqbpbsMbFeTmU9Nqo=;
	b=cM8QqDQn+eq8x+hJcy/OSiX6Jq+MB8FJE/BXOIOPc461hP2seAUJLlEn2bDGmv/k0ri09ixW9d+cQd83JvW4X3Y4oKTMwcxYbgU9dA1qNUh936BYve9IvuFk5pALQduXzBJ3Xhb6r8futo2hHA9ufEsxA8mWEPCsRy63mkyDjSQ=
Received: from 30.69.38.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wuhk5JA_1765637160 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 13 Dec 2025 22:46:06 +0800
Message-ID: <2319527e-6e4e-4a42-9ad4-bfd395d25f39@linux.alibaba.com>
Date: Sat, 13 Dec 2025 23:45:59 +0900
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
Subject: Re: [PATCH 1/2] erofs-utils: mount: Check the status of subprocess to
 avoid infinite loop
To: Yifan Zhao <zhaoyifan28@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: hudson@cyzhu.com, jingrui@huawei.com, wayne.ma@huawei.com
References: <20251212101733.590089-1-zhaoyifan28@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251212101733.590089-1-zhaoyifan28@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/12 19:17, Yifan Zhao wrote:
> In `erofsmount_nbd()`, if the child process forked therein exits
> erroneously within `erofsmount_startnbd()`, the NBD device will never
> become operational. Since the parent process does not check the child's
> status, it will stuck in an infinite loop polling the NBD device state.
> 
> This patch ensures the parent process correctly detects this failure and
> returns an error accordingly.
> 
> Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>

Both patches applied, thanks!

Thanks,
Gao Xiang


