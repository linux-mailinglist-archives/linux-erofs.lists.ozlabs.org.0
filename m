Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF3A13567
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 09:33:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYbjq3DPkz3by8
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 19:33:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737016413;
	cv=none; b=mJJgd6fCNkTznaupqoZYvybvtLj50Bo0sY4/Gk4wM5V/b91Esd2MlJ9k84APST/asn3IT5HHR1U5XjjpsbGrLVKYqEXthsS7nHREg6h1Wx9wTd77BtxK7DWO+HoGxIR6RNXHriIuXmN6+6aoiKaNI07hC4Y3Us6WGPbgnbSQc0rL/MsdX8rSdIEPX5SHftxXOlgmlPgbI63vpa4LQWLSbLQrYsJJhspK81RT8MFIGodBKmCGdI/f0orYdg8V62RvbhUdpkPtqFR4QWGFfWX7qbSdaQzSwvtJhOCdF4tGQG0FsBMMdGXZ4ygYSvdhIVhb5nOp5uEOLM120/vL3Q5f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737016413; c=relaxed/relaxed;
	bh=PHfQkkB55ebGdxpOI6zf43XLyTVnn+B5ouE5AZYqxj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDzUhyxICuXAB8asF0+BxxoFUSVkF1jLiOrS41b7TjKXeY8w+Ca45YDnzTiD2DkRc94jtrlh4E0LQwCgeK6RAvIUCw0w2i6aYIK0KnK9ZjCeo6YckzY9FBtxMFC4aOC0MsgIqgwUHy6HrhfmHILTn4NNJXzBOY1gJ7wtHnTBx0A2ucqcZ6Cj3pHTIh7oOnq4lGKHFKX3iaXl86M+TfzyxikYwg0JVNeQGYrGXnsPnxaOEw4yk4xJS6kytPqlZMjXGFHhT371JgWoyGEVe3zC69Z8JGcC8FBF+flSftJPNyoB6BAq4wI/WkUBTCBK0c9srUOWqFFUqt7DPRwYNPW5mQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pFjlOeJ2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pFjlOeJ2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYbjm40kXz2ysc
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 19:33:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737016407; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PHfQkkB55ebGdxpOI6zf43XLyTVnn+B5ouE5AZYqxj8=;
	b=pFjlOeJ2wQuowjPEunvaIRbe5T/UHvFjYo7Q5q1dScKzS7MUCmxzvLBoWY4Vs0UR6/94M3omQjbOOmuHo1w9heTGC+e8eEdj3Da17C64vdu4o3dVpiMkIA0ouJgUn0l8olE94XQR5lU1IBKOFpEbOPrBq27iaQPpXXcXMc1/WZA=
Received: from 30.221.130.221(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNl7TR5_1737016405 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 16:33:26 +0800
Message-ID: <c9dc9da7-0085-43af-9d2a-130dec379dfd@linux.alibaba.com>
Date: Thu, 16 Jan 2025 16:33:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix potential return value overflow of
 z_erofs_shrink_scan()
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
References: <20250114040058.459981-1-hsiangkao@linux.alibaba.com>
 <11ffcd03-c3ce-4d2b-8360-1968092f72c1@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <11ffcd03-c3ce-4d2b-8360-1968092f72c1@kernel.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/16 16:31, Chao Yu wrote:
> On 1/14/25 12:00, Gao Xiang wrote:
>> z_erofs_shrink_scan() could return small numbers due to the mistyped
>> `freed`.
>>
>> Although I don't think it has any visible impact.
> 
> Agreed, it's an extreme case...

Yeah... also thanks for the review.

Thanks,
Gao Xiang
