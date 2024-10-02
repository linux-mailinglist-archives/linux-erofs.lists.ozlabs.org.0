Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7AF98D22E
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 13:25:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XJXY86c6pz2yVZ
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Oct 2024 21:25:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727868330;
	cv=none; b=FsmjqC6xFaKcxmsB1g0JrtviXZTLnnoyY/VW1ClmjiZ0ZAL9/R0k7vy8Aun8siIIZLbOVPOQFVflIApsA2Ct0I3bbljP2zRGIsw5wGA3vfzgUUV6/u2gpFMn4/rJBl044SaA8HeigXy+2LXrqYu3Y5qZxTNciqQUauMFZ64i1q5c9cTFIcAbTQ6r59DfaaVkY4PAEmr+6aah1wDglGfSH8RTrgRP0uYCMNlxt/yycRQAvqa/Yoqkrzc6tTHEh5JT3r33f3e8abL6t+d0PX2VN2KWGJqgoaplYt+aFd8eYKfXItIj+yN/o1k1Bk1Kawf+wCHVPMt+nmMwa0GBrNIn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727868330; c=relaxed/relaxed;
	bh=xEwxijDeSh+VJN3BJ+JAiKDblgWvKqGAbbaQA2kzvZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFwwOUxASCuXqM2rMHN9JqG5T9m1j2xKZ+WKt63lGfEl6vUnGcoRbB2SrWv+F0Ra/8Cv+4KBM6gZFBwsLore4VLLAKNRm9uziBZ71I0fVLsFOenZACvYdH65qum1/xd3ligW10mw1VnAuze/DTDDmoG/1WiO0n/56e4fbhOM0IhS60YGsVBghV3I+ZJVxRXqqkfKmcvzpnrN1TPqt4JGtkOSZfSkOyO0f+gFb58qm+9rMBr7kxMeY4N7XrZ5xkaV/AroRLU7yqKQLnI2007CwGluKp94UWXCQwTDV1T+zF2k6eoQnLjR1DwTSsuB+VXEh+y+uUF/Xa+V1/dNVffeJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WXRt8tYE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WXRt8tYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XJXY25bVRz2yNt
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Oct 2024 21:25:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727868315; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xEwxijDeSh+VJN3BJ+JAiKDblgWvKqGAbbaQA2kzvZk=;
	b=WXRt8tYEG+6kNNmfBt9hRy23j61WBotIFyRfHFz8+iTGj8axnmbokADWDEq4rDLSHFMD160q7TSckrUtPlg2MjYcLMe9iagTMaOLbvPI4NCx0H3cRwI7Mn6n8dTkF/JoVdzlXROvmHTjnOmC3OhJxAq9thDFj1jKtcJ9v63yLgw=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WG9ymnr_1727868312)
          by smtp.aliyun-inc.com;
          Wed, 02 Oct 2024 19:25:13 +0800
Message-ID: <7cde8511-9d56-4366-aac4-29dfbd8c76b1@linux.alibaba.com>
Date: Wed, 2 Oct 2024 19:25:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
 <20240930141819.tabcwa3nk5v2mkwu@quack3>
 <20241002-burgfrieden-nahen-079f64e243ad@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20241002-burgfrieden-nahen-079f64e243ad@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-erofs@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/2 14:12, Christian Brauner wrote:
> On Mon, Sep 30, 2024 at 04:18:19PM GMT, Jan Kara wrote:

..

>>>>
>>>> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
>>>> index 7dcdce660cac..1428d0530e1c 100644
>>>> --- a/fs/erofs/Kconfig
>>>> +++ b/fs/erofs/Kconfig
>>>> @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
>>>>
>>>>            If you are not using a security module, say N.
>>>>
>>>> +config EROFS_FS_BACKED_BY_FILE
>>>> +       bool "File-backed EROFS filesystem support"
>>>> +       depends on EROFS_FS
>>>> +       default y
>>>
>>> I am a bit reluctant to have this default to y, without an ack from
>>> the VFS maintainers.
>>
>> Well, we generally let filesystems do whatever they decide to do unless it
>> is a affecting stability / security / maintainability of the whole system.
>> In this case I don't see anything that would be substantially different
>> than if we go through a loop device. So although the feature looks somewhat
>> unusual I don't see a reason to nack it or otherwise interfere with
>> whatever the fs maintainer wants to do. Are you concerned about a
>> particular problem?
> 
> I see no reason to nak it either.

Thanks all for taking time on writing down these!

Unfortunately, fanotify pre-content hooks was't landed in 6.12 cycle
(which I think will be used in a lot of scenarios)..

I do hope it could be landed in the next cycle so I could clean up
the codebase then.

Thanks,
Gao Xiang
