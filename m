Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B09A2E665
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 09:27:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YryPh0hX6z305X
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Feb 2025 19:27:52 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739176070;
	cv=none; b=I9qAyQgnKYzl/8HZRcDErD2Tj7sPsr2YDXc7BUzkG9Dvf7Jk6E87Sjc3UL14VFZuIrA0C/F5VtQjyoPNn3hFZW3K7ykiBWUHmfa9//YQIVTqSj8iGHFWFV3ou1XqCG7ogtf1Sr/gBueNjxgOG5xcjlJxXnbGqeYZPwvpGEL0VEQm4a8wz0CWIxWOTAYq/gw8ok0vAEr2QIbkztdJAria5kA9SXqLHanLMp8u0nJ2zVWaVF/h3otJedslp2/kmt8hMsZPcbVJYhD+tnYesVd6WHNWdgqxJtFeZ4LCzZ8RjbqKkdlcq4z+bCyUBfG37X5VspZD5yFvgoYVIJLlVkpzQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739176070; c=relaxed/relaxed;
	bh=TWuE4lQOz0gx649DxJPkbLkDmKgtaRuILeaeAkiIgFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIiXx08OKus6oNX1lPf2wmfAZdIRP/ZCQ/77dDTPFioikdjU9Qwcq84Re+S9hRVmYX8L2XuBK2tHJkTntaKGACXb49jZRh8bgFozcSam+dhVQ+B8k2wpaUkXJKMVR1vJrWiBJ1ZVOQd6ffzBIjzTvvH3R/uyIBKWdSMNWL7X6URwo9OAASByuiRhWtgoaxulEOHozj9h37y645OrxsKVGYBOKWAY/qKlfLrWMcmR6O3CXXnPthBxiUwXDBJ0pRxbMMne2qbsD4kWOQhL3kVr5Oa538Ozn3Ikc8eRGeDqkkSbB+n87YCraWUwWiSzzsU2vykybsy7CxQjgdarrlvOZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cUC3rt5E; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cUC3rt5E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YryPc2Wjnz2ynf
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Feb 2025 19:27:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739176062; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TWuE4lQOz0gx649DxJPkbLkDmKgtaRuILeaeAkiIgFs=;
	b=cUC3rt5EvqpqvJc7zF0e88QqB8c+PdzwiWVoq+RRfvwClXjXHv8D8aKHRlb1LKw+er+d2/GQ2YETJfeK9AkG1+YXcb5EuIP89v+sStjzSCsUnXP9rSGd8STLpjTe6FNAshWCIoQ4oh5mtEHNgka7Lv9b7I1Eqi+va4ASQOvbxPo=
Received: from 30.41.15.245(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WP80Bv-_1739176055 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Feb 2025 16:27:40 +0800
Message-ID: <a37e2ae3-257c-400f-9abf-858b25f15ac2@linux.alibaba.com>
Date: Mon, 10 Feb 2025 16:27:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] erofs: use Z_EROFS_LCLUSTER_TYPE_MAX to simplify
 switches
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250210032923.3382136-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/2/10 11:29, Hongzhen Luo wrote:
> There's no need to enumerate each type.  No logic changes.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang
