Return-Path: <linux-erofs+bounces-190-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F58A85188
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Apr 2025 04:21:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZYgR66SYXz2yqR;
	Fri, 11 Apr 2025 12:21:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744338082;
	cv=none; b=m8AWRYl7Dz/BhE0BATWd6cVd1QMbIE7JrYfSb7/e5D3+iP7L/dOQd9fTziM3QWCQlRFmyGMF7dS7gpzPjzgHd0LnfqDyZIhYjR81ZQQvRyPygaO3x/kF3JVt1GCRCSNSuSx5O4u5Eo1IcG8q/EyLaUM/C/6KC6HnuDzRTK1BI7i8rxydUzoCITcHhK4sA9Q/qpxzmFUYZZUE2Sal8b86Q0gbg0HkzIB4EKMBQD91i01XKwuJgw+0/OWxOIaKQizXIAHQPgtpLTaHtHH2BKekfa8W1g0QLCAgY2Ep4akJ4PSOEyEmVjdj2b8xQhBumlOOjZk420Lc18hD3W/icGdp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744338082; c=relaxed/relaxed;
	bh=WsdzbPDZEvqRIfhQrr1WvttO0/5ACYFGFAiqyk5n4h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcU1SqoBHJ2jHTk5Qsts61c38RTbzmjjqMmzdstPS7RZrXD2rEI4tkzSbukmdWThqp13wlLdhJxOgiOMFZdxI1FhPCRdRnL3CIX90qww/q7MdeStK10Tk1dDzZ5LKIj1NGcidcrUaV49i0YL9cbUNArSUFxermFHkgJvHY0g0vpFZK9l+IyCzs87dgHnrZsXnBECJ2Eko0A2I5yW8riILeW/8HMZsglbiNZAII1rwmGB78QmjnVdCNbHMtqEP+jUFkoQxcDNiBOssIO98uNiJ41n85gDshUFM08JdQctuNOph0vb7vOFQZCgYfmJUtOpkwZYlcjPnDEL+9dKU+hazQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QnMA2n3Z; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QnMA2n3Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYgR46kcZz2ySp
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Apr 2025 12:21:19 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744338075; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WsdzbPDZEvqRIfhQrr1WvttO0/5ACYFGFAiqyk5n4h4=;
	b=QnMA2n3ZnjE0PqnGLTFcyrIQyul7hjtvzJK2joaaNSEaJo2UUaocSjZbawo+SiuzPfmMn6bVeUxbZi7t9c4Ks+dgw2Q0MmvxLRSfmzMmt2tjNhBXR+sCPET67Fz56v6RyHKENtxYdOOKPI1LVfV9Q1QChoftUSFkVEoHv3NIs1A=
Received: from 30.74.129.90(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWREN7F_1744338072 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Apr 2025 10:21:12 +0800
Message-ID: <2d8d51e2-0126-4f23-815e-30d91f5d2411@linux.alibaba.com>
Date: Fri, 11 Apr 2025 10:21:12 +0800
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
Subject: Re: [PATCH] AOSP: erofs-utils: mkfs: remove block list implementation
To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, Kelvin Zhang <zhangkelvin@google.com>
References: <20250406112735.348328-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-SoRgMXVZF9fqFKw+_sCNCNp3hYznL4oWw44+spgbzWNw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-SoRgMXVZF9fqFKw+_sCNCNp3hYznL4oWw44+spgbzWNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Sandeep,

On 2025/4/11 06:00, Sandeep Dhavale wrote:
> Hi Gao,
> I checked with Kelvin, and now AOSP has an EROFS image parser so block
> list functionality is redundant.
> 
> With that,
> Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks for your confirmation.  Currently I have hard time,
I will reply your patch this weekend.

Thanks,
Gao Xiang

