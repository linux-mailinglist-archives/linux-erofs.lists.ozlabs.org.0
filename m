Return-Path: <linux-erofs+bounces-1195-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F39BE5DE9
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 02:19:27 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnln86kkRz3069;
	Fri, 17 Oct 2025 11:19:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760660364;
	cv=none; b=fUpoc6AH/pViVKs+aYNS9RZoVKlZqkJcYYYFKNt5kC3Y2DPd45saqN/s0k9QFVgEbQDRdeGvaS4x9z0CBVC0fDw5ODqbDz+vnfp0tZjed5OL5aKhdDYTdRKejBGq0AnGPdPOVpWl/qF0P0wfHcbPPZMUDDZkUPLPzdpc7a7KKcJUvpcTBfqFdS05BUFcY9pT4NqjyiBSZNR9cbXITYnldzsliY9+zCZdbWx7JeG5LD9jQx6fJkuFj7PcI5CgY1uEExGYtcEr2XMZ89aWG5M96Fv6LDtAyz3KLlek/hTAiH+4TPfXKOcmgqEgAfmc64A1gOd3QVYOha8D4qcBd4N1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760660364; c=relaxed/relaxed;
	bh=XsBlbLi94MOYNZOj/TpZI6VGLFJeB8acPCcWz1+SBwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkWQ0jiO9dgYA0Kws5+TbipjeTlnUex0EtSmyuA3nbdtGB/h1oAkqwNeLykDInDxQ/5rOQaA6h9PDSLaHAJ/+2Q9CtNe7pVSaqVUfNmytZiN0K2yXbqCjLPsJWmjdF23KHt8nd98kkWuqe3weWNmrOIf8K1Ft0WEUhmzJfL+0AWReOxeYNUK6BDKEW63UPhOjxlqYopwPmnzW9evfzOwa0E9+rytLhVXhxeKBDLPzofslDTleW7dcgR3C5yyNdVznr6gJ/Y8VIOw1SGc1o9QbyGpM/WN6BioQQPsdr1h1CPDmPaJqQiYhKa5zDica25Sqx4rWmufdX4ozLOScAFVvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=X7diX/lu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=X7diX/lu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnln66wmSz2yqh
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Oct 2025 11:19:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760660357; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XsBlbLi94MOYNZOj/TpZI6VGLFJeB8acPCcWz1+SBwY=;
	b=X7diX/luqy29ikmnjkNTmXB9wU4QBfwOL10AgMfkS/dF6IajodPHXodPLhqpKvT3pIpkvSL585nUneSIejjEYiCBZvrMHWfp06W3n97ahWg3FiCiiWXkyJlrD+e/1l31VyMQfOdVsYJx7vy6NLZPlf2mIjh2DEqXu69Q9ZOyqfc=
Received: from 30.134.15.121(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqMOFL6_1760660355 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 08:19:15 +0800
Message-ID: <c859d060-88e6-4dcb-8abf-a6aa335690c5@linux.alibaba.com>
Date: Fri, 17 Oct 2025 08:19:14 +0800
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
Subject: Re: erofs image that can put z_erofs_scan_folio() into an infinite
 loop
To: rtm@csail.mit.edu, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-erofs@lists.ozlabs.org
References: <35167.1760645886@localhost>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <35167.1760645886@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/10/17 04:18, rtm@csail.mit.edu wrote:
> This produces an infinite loop in z_erofs_scan_folio():
> 
> # uname -r
> 6.17.0-12747-g859be217ee9e
> # wget http://www.rtmrtm.org/rtm/erofs6a.img
> # mount -t erofs -o loop erofs6a.img /mnt
> # cp /mnt/x /tmp/y
> 
> I'm afraid I have not been able to track down what is going on. But
> one factor is that erofs_inode_extended->i_size is 0x80000000000fff;
> changing it to e.g. 3 makes the infinite loop go away.
> 
> On the other hand, here's another image can also loop forever in
> z_erofs_scan_folio(), but has a more ordinary i_size:
> 
> # wget http://www.rtmrtm.org/rtm/erofs23a.img
> # mount -t erofs -o loop erofs23a.img /mnt
> # cp /mnt/x /tmp/y

Thanks! Will look into those soon.

Thanks,
Gao Xiang

> 
> Robert Morris
> rtm@mit.edu
> 


