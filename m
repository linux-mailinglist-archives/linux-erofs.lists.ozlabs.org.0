Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379B39F0598
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 08:38:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8h5W205Hz3bNs
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 18:38:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734075485;
	cv=none; b=Jpy1EF8MCFBHWZ+Wrxx07YES0MilCWNh46C3h24di6Th9Rkt0tHgnP872hvRB3jbAUxEIFv3Fa5PGq4JMyMBDxH1Uwqf21pANqXIkDrQBVtsGaDb+x4Rnr660FZAhkRzsUjxqkN2+tz484LZ0oxyUnTr3MjuqQyQxOLyZaVwUY/g3eYjPGfd0Xp0JCoEPFOKZyYtXQ40c4Plk9VBjtmUEVv1xlhGmp8Lbegt6kXzypL68svdTcwrzAqPse0GwXu6rpMfMjWoa5q+NvFSS7GNXwvLcsqL3UkKPO1Lx0VVCiFEKaa6t9g/gtA69E9ae5L7QPV0+zHuhON9tloobcqbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734075485; c=relaxed/relaxed;
	bh=07RLSQXv1qUy+3yhkHoMR61NBgWiLGHykKkY0iCxgXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkebIwchPcqvOIOqyWg7sKUX+C9L5aGAnkUbge/jV1y+EaVWA6lz3MiOU7TXN2+Njpix0Ey+fgaaqPMocn6ptMyiTYGb72Bp+ueaWLNQrFr8cDrmLYfXm8wn2r9Xd57IDGrRsjH4fhJvEHC77fXOY77x/0r2Rh/gJCvyLd/A6di8cjQSHKENFUiWCYcYVCXGEANOrHXWkWZgAheTFXCJgMEc63yqojHD1jh7rCqj7xL0ylZeRdJkle31/Nvgs7UJh2UfwsF2vQ6YZBTX0H4O4IOc4Off0jjrRGVDk5UqmuhGcRVxVCvRE52Bh0QzDxQnj9CpfgM1aT7KUvNmriFh8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DoCFlMTX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=DoCFlMTX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8h5R1fLKz30h7
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 18:38:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734075477; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=07RLSQXv1qUy+3yhkHoMR61NBgWiLGHykKkY0iCxgXQ=;
	b=DoCFlMTXwVj4F9hF0XKAWoVvzL97EJb6XnBX97+iPit5RoIHzv0jVdIHDI46Tigcs5x5/pUS2NacBFVEOiPohALgtAw99TUTBCOYpd0AAI/dHft5U1oB9Lhe4OeIF64yNc+M4sDfABNdebWXh/fgOb8fTWwD3+VBGxBBK7G+N0Y=
Received: from 30.221.130.36(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLOAVxo_1734075474 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 15:37:55 +0800
Message-ID: <398413dc-95ad-4ab9-a387-e44aacd68aa1@linux.alibaba.com>
Date: Fri, 13 Dec 2024 15:37:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: correct erofsfuse build script
To: ComixHe <heyuming@deepin.org>
References: <8725A28257A20420+20241213063250.314786-1-heyuming@deepin.org>
 <c70d771a-ad46-404c-80c0-4285e0f3ca72@linux.alibaba.com>
 <B2733E792B2EBCBF+0f237c6e-2465-4a35-b863-2ddc32cfbf70@deepin.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <B2733E792B2EBCBF+0f237c6e-2465-4a35-b863-2ddc32cfbf70@deepin.org>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/12/13 15:24, ComixHe wrote:
> 
> On 12/13/24 14:39, Gao Xiang wrote:
>> Hi Comix,
>>
>> On 2024/12/13 14:32, ComixHe wrote:
>>> Some of the symbols required by erofsfuse are provided by liberofs.
>>> When option 'enable-static-fuse' is set, all these object file should be
>>> exported to liberofsfuse.a
>>
>> Could you give more hints why `lib_LIBRARIES` doesn't work?
> Certainly.
> 
> Today, I attempted to build the latest stable version of erofs-utils and
> export liberofsfuse.a.
> 
> However, when using liberofsfuse.a, the linker there reported several
> errors:
> 
> (.text+0xff): undefined reference to `g_sbi'
> /usr/bin/ld: (.text+0x110): undefined reference to `g_sbi'
> /usr/bin/ld: (.text+0x116): undefined reference to `cfg'
> /usr/bin/ld: (.text+0x12d): undefined reference to
> `erofs_read_inode_from_disk'
> /usr/bin/ld: (.text+0x146): undefined reference to `erofs_listxattr'
> /usr/bin/ld: (.text+0x1ae): undefined reference to `erofs_listxattr'
> /usr/bin/ld: (.text+0x1e5): undefined reference to `erofs_msg'
> /usr/bin/ld: (.text+0x1ed): undefined reference to
> `erofs_read_inode_from_disk'
> 
> I adjusted the build script according to the patch content, then rebuilt
> both erofs-utils and my project.
> 
> After these fixes, everything worked as expected.

Ok, thanks.  Maybe I think it should be called
ENABLE_LIBEROFSFUSE since I guess it could produce
a dynamic library with libtool too?

Anyway, it's not a case for general end users, as
long as it resolves your issue.  I will apply.

Thanks,
Gao Xiang

>>
>> I fail to get the point why `lib_LTLIBRARIES` is needed for
>> static libraries...
>>
>> https://www.gnu.org/software/automake/manual/1.7.2/html_node/A-Library.html
>>
>>
>> Thanks,
>> Gao Xiang
>>
