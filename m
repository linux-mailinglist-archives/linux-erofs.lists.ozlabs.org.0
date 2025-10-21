Return-Path: <linux-erofs+bounces-1266-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772EBF5610
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Oct 2025 10:58:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4crR6J5pcnz3020;
	Tue, 21 Oct 2025 19:58:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761037112;
	cv=none; b=eV6zMShdu0bZFhZD8tSq36i1CgxIEHxWi1H/P8XdJEJJ81xUlM2gW5gScH4sDV4NN5GS1XtrnjI2MNGoFwt/nVdEUfwA3eSvE2gqQGU+VZLtRljG2L5R+FfzxjOYw+BRTk249S/eHjyqexVlUK+ZpIGfKWehi3bdLki5KVCKMywbJbxCxAAc0GvaJiYkgkVfvSu0nVcWfxxPAv5a3ypehGNXmrT9S80JIniUt4SDOxKH0nBKoMq14HeJcm54ebLZLQ9oYak2yHDxfXaPFGWF4SU7nwJNpQ+7GOUq9lo8xbaXwdWeFRsQesoAa56KcsZ9QefJfgfsq6FxW4rVivlrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761037112; c=relaxed/relaxed;
	bh=F5ntCeS2hRdXPsb9ks2iVLTbcg9wgv2i4+qdOepQ7sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mn1qVmKkKymqrnolDNB+ZMFTPX5T9h3rRTN4BkWNCKu46lCpdED7ObWqEDJwoSeaFiqT2IjkPK9uE6MYWqBBLWuVPt4fAQq33lGWH1Vnh7nmPgwmGTEnZVxxfk2o/IGSw6uMusgOl98MOVpYa0HOyi/ggdBWyANIBHVVj/hE3qywQ3yTgBDvxT8c7fFB+ufOoNicLbHoG28kGfZ8WySsIAawl5NmYu8N/JWX7oVsa5Ge9oQsWwmhBptlEi09R2vb6stiHLj0G42eJSwICkF/v205+uMNoWevGjfW2C4XxmXw7ULVOOiWyJCBb6OuGVPZNwsa8mUQxOzbes77bd7Tww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GjZ2QcvK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GjZ2QcvK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4crR6H0Y75z300M
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Oct 2025 19:58:29 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761037105; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F5ntCeS2hRdXPsb9ks2iVLTbcg9wgv2i4+qdOepQ7sc=;
	b=GjZ2QcvKf1U/u0p9u+A45bqnA9fKcJOeNyd4LV712bP5VT2mYMZHw7VgUZAv7lFerBkCbjhoHYbxuSTqD6Kw8HuL30SkXVkrDJOJ7ZGwIogvitXV1mEXSKxynpp7SQ1uNFvqiLP+pH9EGfFUryMpr7tQpdTVYl0NKwO9CPYbipA=
Received: from 30.221.129.100(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqiJFKl_1761037103 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Oct 2025 16:58:24 +0800
Message-ID: <41a05d15-af28-4178-bab0-52c0ffa07368@linux.alibaba.com>
Date: Tue, 21 Oct 2025 16:58:23 +0800
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
Subject: Re: [PATCH] erofs-utils: fix to return correct err in
 z_erofs_fill_inode_lazy
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com,
 linux-erofs@lists.ozlabs.org
References: <1761034164-29967-1-git-send-email-zhiguo.niu@unisoc.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <1761034164-29967-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/10/21 16:09, Zhiguo Niu wrote:
> Otherwise -EOPNOTSUPP and -EFSCORRUPTED err cases would be handled to
> return 0.
> 
> Fixes: 3871365cb629 ("erofs-utils: lib: use meta buffers for zmap operations")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Thanks! will apply.

Thanks,
Gao Xiang

