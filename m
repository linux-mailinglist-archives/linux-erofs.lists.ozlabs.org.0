Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6039E6A9B
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 10:41:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y4R962S79z30Yb
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Dec 2024 20:41:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733478088;
	cv=none; b=eig/cq2zbCZwjzr/CXjh1OO6XKo0z9kaEHUtGU8Mkndzvo+bx7FcUCy1E4syPs6Y/C2/NgAcv6mexXzpDoXX/nOklaD3FpyV7KxEQkKSffL9MasqhRYZeHZ+XIavmGej5ayK2D11kntRf8TywkU/iAO6v81AKGhLPM5OwTjsTiniGd/D57zgDaAyMrN4jk2MJ0+sGNBldXfnf5Hci9UpV6bXCs6rqkbiCGf3z1NVHacWWUnL6xnYyD+P59zF8JiEn4EQONQwQUT8y1CL8EJwTn7Zv2W3cTf+mhusuVreoXZP+iaUEsrWQ3gS41yE36//Z4ceyurU+BDUKrSMi8rbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733478088; c=relaxed/relaxed;
	bh=ndP+sSQK0US/mFCHQ2MRkF9rwko2Te0FiYFzA1cge7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeaPXEEuiZqp6A3zc7awwZs1FgZBLkvEKPVtfKMAaj8EZOgZ/SEQW7m0ZieI3uORILH4W10Keg0Dlyt5HEwpS9pLvXaaL3VH3DkS5MADt1vljD4twaOHpwwoC6H5ez6THFW8fx1d0YiA7ZVZqVVYQlrTEwPoX6kTUqKLb8dcPseT/Z4x2q3ynWCwoSvPMvP6SGuV7bWayzOzMDFUXLP9tgMd4gUi1A7fyUueXFCCsXthQVqxYbLiS5yaVI5Q3Fd6Rhd2GA/rFuzEdhjZ+GFRrJFIgWNJLDkMfHzSjoUa6JS0hbbnNVwCX+nVHxiBJ5yMkUrVSYaPMu6df9ye/mJ+9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OP3itcUy; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OP3itcUy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y4R906t1qz2yGF
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Dec 2024 20:41:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733478074; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ndP+sSQK0US/mFCHQ2MRkF9rwko2Te0FiYFzA1cge7M=;
	b=OP3itcUyv+4YXfCTtlYY1IJalDZWlgW9bVme+Ye/mbM7+DYZg2FRSKZ/sI4BjaiXMPAmzuCVZ+X+74c89PzKfToEGLfjZiNcPQJT5JqsrwzkBk7KAivqTKNnM2T7zLYg4phNu8MSwRBPJt2Xai8FD56mQwJt5K0XWPKaJprf1Ow=
Received: from 30.221.130.17(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKwD-8w_1733478071 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Dec 2024 17:41:12 +0800
Message-ID: <a9d7b248-8c78-489e-99cb-f42d0c735d2d@linux.alibaba.com>
Date: Fri, 6 Dec 2024 17:41:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "erofs: reliably distinguish block based and fscache mode"
 has been added to the 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>, xiangyu.chen@windriver.com
References: <2024120228-mocker-refinance-e073@gregkh>
 <9e9d4558-3e45-4dad-9685-1e3feb693957@linux.alibaba.com>
 <2024120622-prankster-lagged-01c8@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024120622-prankster-lagged-01c8@gregkh>
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
Cc: Christian Brauner <brauner@kernel.org>, stable-commits@vger.kernel.org, linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Greg,

On 2024/12/6 17:33, Greg KH wrote:
> On Fri, Dec 06, 2024 at 01:05:21PM +0800, Gao Xiang wrote:
>> Hi XiangYu,
>>
>> Just noticed that. Why it's needed for Linux 6.1 LTS?
>> Just see my reply, I think 6.1 LTS is not impacted:
>> https://lore.kernel.org/r/686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com/
>>
>> Also, it seems some dependenies are missing, just
>> backporting this commit will break EROFS.
>>
>> Hi Greg,
>>
>> Please help drop this patch from 6.1 queue before more
>> explanations, thanks!
> 
> Now dropped, sorry about that.

No need sorry :-) just wonder the cases why we backport
this commit.

It'd be very helpful to get more hints for this effort.

Thanks,
Gao Xiang

> 
> greg k-h

