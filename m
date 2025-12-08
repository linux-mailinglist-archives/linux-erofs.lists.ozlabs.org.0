Return-Path: <linux-erofs+bounces-1488-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A95CACEDE
	for <lists+linux-erofs@lfdr.de>; Mon, 08 Dec 2025 11:56:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dPzSW1sH2z2yQJ;
	Mon, 08 Dec 2025 21:56:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765191403;
	cv=none; b=J5azeH9EZDFGtNBOoKMDSYC5H0937yCfGu/oWfRjGzkH8CyMkPyQVEIJaf1wtYJg6Yz5A2hJAejRRrkaSncYPZ/gg03GF1PvtUjk4WyARmZahoiTfs9kMcubt0A+Gu1WRbeZrEB7gkptP7DARRHlG5rEOgI4dSpCo+5QQiA7eOus4Bu6ilNt19NWAH1YW7lYccZ2pvTSdITfTRwVMjPwfvitMQ02YY2enes8wZQGSsQO8DZ3xT9lvKoyAsKgPNqnam6TcMhJscu5+pQnV6EXibdpwqag1krRI1aMo9iOStFFVXld4SzR1a1bHIFUHbL6ixn1YKTuzEwjyf1mgrfW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765191403; c=relaxed/relaxed;
	bh=heECU7DyychpYD8Cl2WPYk6PErTEaOAEEKnW80MuLBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlHn7+kyj10hvBF3/SlHsDr+sAPm3i7dEDX05iNuob6+avk9IPp8sJZyHarNllSXF+vGG2F9o6In4fyRYTu3/ZoVjOZ1BL5m2sQH2DWY9XLLg/UBgaDbLUu/OdQdiZOhzmyB7NSqlbDMljOObLN4+jpaQONM4SrBXM+CUlZBBHKfU5wRawHj2mXZAU4FH89Dr5JhPjg9ktCLf0jUwmSM80jwLrj/vxd8Rx6M5PeA0UPO4mc1gB297+VfYaX5cCOTactJK3hA4qG5H2th6e8eqUgFr2vE1hRPgDLhsjxDgZDvZml/i+qtrVWzB8EkBTWRisUJ5x7EZNXw/SKDsB9BuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ka91SduT; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ka91SduT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dPzSS6w98z2yPR
	for <linux-erofs@lists.ozlabs.org>; Mon, 08 Dec 2025 21:56:39 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765191389; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=heECU7DyychpYD8Cl2WPYk6PErTEaOAEEKnW80MuLBI=;
	b=ka91SduTBN7qHQS7ZBNYnBXqjdDHWvWw6zZPHU9Dbusc3cnHlJ4nVu4fXqRDkroiF6CwOzzxd8HbSw/36xiWsbv/wZuvQZoq189qwGq7+BhVrp3m8DYhSlJWKv8dF2ytC+8B0jd+ciPR4WioU4PtSNJmhRYzC0K4pd8y8CvDw8g=
Received: from 30.69.38.206(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WuKbL4z_1765191382 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Dec 2025 18:56:27 +0800
Message-ID: <e4bcafb4-a9a4-4218-8cc2-88150e009319@linux.alibaba.com>
Date: Mon, 8 Dec 2025 19:56:21 +0900
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
Subject: Re: [PATCH v2] erofs: Use %pe format specifier for error pointers
To: Ferry Meng <mengferry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20251208093138.127880-1-mengferry@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251208093138.127880-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/12/8 17:31, Ferry Meng wrote:
> %pe will print a symbolic error name (e.g,. -ENOMEM), opposed to the
> raw errno (e.g,. -12) produced by PTR_ERR().
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

