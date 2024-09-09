Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83796970C69
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 05:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725853295;
	bh=+r7iT7AXesM5Oh8E2udl4K2BqAgIz2rH1BT9FqgK1l8=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=f2Zcz1qzl2N9aKpqEWGVZ3zgW1eP6zgWAs0u7fKqYlid3gi9mZ84lGmlsQ8oOCx8P
	 3JmZgeIRwc9lWb+U8riaSWztoEdq2eaozPszP78+WYIPbH1MmLS/l0zsF0UR3AlIU5
	 YbkrU9sfUAAYnt+PHKZKV15dNmaDTsaQsFhy3MxKsh4geAWehmQSmTTeWDeFqCrYx7
	 Hky9f6Smf7kZmPHpj8I0vM7aTMjE3xP/pGtwWKxtGC8g3H8AWzDnhx0lNgO6+txzv0
	 7nMugv9Zpc5oTWWiPVPbgutbTkR5xhNZXvmKmMJ3V9FqK8lW6O2rQ+QW4POBLnHq6U
	 xCPyzXxtzT5KA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2CLR1D9Nz2yMk
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 13:41:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725853293;
	cv=none; b=N2yazBcPGo3d+O73HO3FdrN4xp23wWJM8P25z1K4VPTl/pABZn3ec70vQdAWYGCiL/9d4yN9BDgEdTrElDYm8BdogUxZOSVhtiptm1/t0djgAxRGzL2w4GzJZW5ZAZwTWTtcQrXtL/UUqoZ8iKI2KcNPJMQRaMSAqjWt3/v3HrPrFx0h44hx0oCIgiN9wE8guk1N1q++6bt1nSRJU+UzjyBBXWZcmTcly9EQhkYT8ZQo1CSn0P3cNBJaM/aPXnHzhfkaOkkYyKltLAiPM95yUT9QsvHxE1NbZd3KUEUuwQbKocvRfprNXT+wtaL/e/BBHtovzMOm8yQ69DTGcWVUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725853293; c=relaxed/relaxed;
	bh=+r7iT7AXesM5Oh8E2udl4K2BqAgIz2rH1BT9FqgK1l8=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Cc:Subject:To:
	 References:From:In-Reply-To:Content-Type; b=ilaHO8gN1paHsCqdOw7LPaW2uEumdyRC9MbYDvE6V7XuPQ1m+6o+MAaV7hnh+JPC1DSiW9qHa0qS1TdxN9U1CwTS6GRTw9lJrN7cCusUdqHZahaY+/rVkPDpdg/AfI9woiyOT73TKJNUntEL31gc/1cBnznwWRzoQVzq+kzUsEXYd2rgTHasm/lgnXY/Bo5qPmXn9YyDJxsusLKNSBZYpfVpWIAKNaNXYVbLa9LjtiDf34iXABpkCtX4qzreJuY8kQBD7x07zFvw8gFQtnPhM8Msodda3fT2OPSl0pgq6vYDi5XsBUMTVNRLp+YrwEVVe6Hp+Vjmps9whVZsvZeS4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xaf2Aqi1; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Xaf2Aqi1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2CLN6hJDz2xf2
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 13:41:32 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7C0525C5497;
	Mon,  9 Sep 2024 03:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D70C4CEC3;
	Mon,  9 Sep 2024 03:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725853289;
	bh=IeEym+QIEFtWQkTwYNKOXbQP/NW/wGRryDpC8XnK1KY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Xaf2Aqi1zbEYcRGx/y0/6TgrAB7pvx667F9XxoKJmnkbaEMqJ2dC8BpskUPHxppOX
	 aQZAeYeRgh7ffH455mti5/MLXRTj6grTZDMN9ka9DnvsnGOH5Zf9xSD3JXFly6FazE
	 kNA1vKjcqm21x21o/24FQbaOurJ0RDbPMcki0G7vHaOIwpcGl7Qp4Ut10RR6J6IQHr
	 xRD4Y2mU7Q2RD9Y48PVs676wHeVOfzAdyNtvcigUFN7uLDD4b0HqGATokPJnDiYnCg
	 TD3B8htNrFLZwmkwIhW7yV8xlosDjwXkHaSqxhhBpo7dnDnuMaA1kSxVXJI1pGk3xB
	 o3IPAwtksvuVA==
Message-ID: <0d351b53-7433-4522-af19-395576842543@kernel.org>
Date: Mon, 9 Sep 2024 11:41:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] erofs: refactor read_inode calling convention
To: Yiyang Wu <toolmanp@tlmp.cc>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
 <20240902093412.509083-1-toolmanp@tlmp.cc>
 <94737216-af40-44b0-ab3e-e5bfdbffab5f@linux.alibaba.com>
 <ZtZ2gygmwGSAuPgS@debian>
Content-Language: en-US
In-Reply-To: <ZtZ2gygmwGSAuPgS@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
From: Chao Yu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Chao Yu <chao@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2024/9/3 10:37, Gao Xiang via Linux-erofs wrote:
> On Mon, Sep 02, 2024 at 05:54:22PM +0800, Gao Xiang wrote:
>>
>>
>> On 2024/9/2 17:34, Yiyang Wu wrote:
>>> Refactor out the iop binding behavior out of the erofs_fill_symlink
>>> and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
>>> can only deal with inode operation bindings and can be decoupled from
>>> metabuf operations. This results in better calling conventions.
>>>
>>> Note that after this patch, we do not need erofs_buf and ofs as
>>> parameters any more when calling erofs_read_inode as
>>> all the data operations are now included in itself.
>>>
>>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>>> Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
>>> Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
>>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
>> Thanks,
>> Gao Xiang
> 
> Applied with the following minor cleanups:
> 
> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> index 726a93a0413c..31d811b50291 100644
> --- a/fs/erofs/inode.c
> +++ b/fs/erofs/inode.c
> @@ -16,9 +16,8 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
>   
>   	/* if it cannot be handled with fast symlink scheme */
>   	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
> -	    inode->i_size >= bsz || inode->i_size < 0) {
> +	    inode->i_size >= bsz || inode->i_size < 0)
>   		return 0;
> -	}
>   
>   	m_pofs += vi->xattr_isize;
>   	/* inline symlink data shouldn't cross block boundary */
> @@ -204,7 +203,7 @@ static int erofs_read_inode(struct inode *inode)
>   static int erofs_fill_inode(struct inode *inode)
>   {
>   	struct erofs_inode *vi = EROFS_I(inode);
> -	int err = 0;
> +	int err;
>   
>   	trace_erofs_fill_inode(inode);

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

>   
> 

