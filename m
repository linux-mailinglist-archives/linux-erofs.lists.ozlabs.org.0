Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D8972710
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 04:18:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2nSK3Jfmz2yR9
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Sep 2024 12:18:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725934716;
	cv=none; b=ACkiIRwOyaS1zR9bm8aIu35qx/ycd/ByRRjio/eym2EbY8divpN8Qr/E5M0OV1FapHCMwirvz3PY0NhxCHugxog+NuS+fu9ptoKhRcVV3i55WcP0XZAyjghmn+mF2qbktuIrAl0ilUB1cyr7IZMADUfbI4c1tADvq0lN1tsnkEzCUe+ZXeBzIzg0aoMrmfFw+mf5O4UeVkYcYpfHXRRhMtTSm4rxvMiRX4LUq51xA892m9IpUrqwd7C36+oYCB7v0M8gedeXUEjdVH2eW+1zt5f5rO6mdg8m8o7S5culcRSwQ3nyxi3Lf7lJuyUMdGSFIf1hqQOew1tWlWiuB01tbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725934716; c=relaxed/relaxed;
	bh=7sI9KaaYX52g6DOUH55ov1m3JrSic7QKcsNmJRT+LYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dobOPvDNgfGSS3UujBc+KgHtd0RVzQuidYZkS83ZKqQp8V1PuH6ZdnDGoErTYPDJlxAoJOCbOKreIL6TImqFSG0wYEhqlFcdjl59DYOsgZtnOVo3DUPZaw0zOneP7zWPU59i4uir0FMuYMFQj96wL9+xtbDdkDyYdw59fXjX9bzQdu3DFRe4JaIeWfdpdq6KUi+FQ6vTMQanFCHMMHaNFJ6A1rzyE8x4GGdIrvMEHEeFOrclVvMcdgw1t+6zTlG979gNNxPzqVehOC8n5KoFVtMmdypdKwQWGEbbpXFL7r3GdZhrtNv316FLt3qhFyGxa45TLcnaLCre3K0DiqnO2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GA63VrMo; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GA63VrMo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2nSC2Hjnz2xxm
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Sep 2024 12:18:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725934709; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7sI9KaaYX52g6DOUH55ov1m3JrSic7QKcsNmJRT+LYY=;
	b=GA63VrMoJSBmZkdad5BjhAPsJRysbPG5P7wZcFdkeNf9/xUaBc/v8VQp6oolwbZeu5bRsK6zs36B1ujBrLHmv3kcFUJwJwkYSVXUddaUo5m95Bm7vyox5tr6nlBnQ/LctX7DCU+/Ms1iO7ZhX1NRKbv6YXH7GM+8PG+hGdUDc3Q=
Received: from 30.244.152.37(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEiHvd8_1725934706)
          by smtp.aliyun-inc.com;
          Tue, 10 Sep 2024 10:18:28 +0800
Message-ID: <e137404e-16cd-4d81-9047-2973afb4690b@linux.alibaba.com>
Date: Tue, 10 Sep 2024 10:18:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix incorrect symlink detection in fast symlink
To: Colin Walters <walters@verbum.org>, linux-erofs@lists.ozlabs.org
References: <20240909022811.1105052-1-hsiangkao@linux.alibaba.com>
 <20240909031911.1174718-1-hsiangkao@linux.alibaba.com>
 <bb2dd430-7de0-47da-ae5b-82ab2dd4d945@app.fastmail.com>
 <25f0356d-d949-483c-8e59-ddc9cace61f6@linux.alibaba.com>
 <21ddadb7-407d-48b6-9c1b-845ead2eefb4@app.fastmail.com>
 <df09821e-d7ca-4bfb-8f57-2046c072af62@linux.alibaba.com>
 <91310d4c-98d5-4a8b-b3db-2043d4a3d533@app.fastmail.com>
 <f8a965ed-e962-40a8-8287-943e872d238c@linux.alibaba.com>
 <7bbda10d-cf22-4a5f-be2d-6c100cf0c5ae@app.fastmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <7bbda10d-cf22-4a5f-be2d-6c100cf0c5ae@app.fastmail.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/9/10 08:12, Colin Walters wrote:
> 
> 
> On Mon, Sep 9, 2024, at 11:40 AM, Gao Xiang wrote:
>>
>> Just my personal opinion, my understanding of rubustness
>> is stability and security.
>>
>> But whether to check or not check this, it doesn't crash
>> the kernel or deadlock or livelock, so IMHO, it's already
>> rubustness.
> 
> OK, if you're telling me this is already checked elsewhere then I think we can call this end of thread.

I know you ask for an explicit check on symlink i_size, but
I've explained the current kernel behavior:
   - For symlink i_size < PAGE_SIZE (always >= 4096 on Linux),
     it behaves normally for EROFS Linux implementation;

   - For symlink i_size >= PAGE_SIZE, EROFS Linux
     implementation will mark '\0' at PAGE_SIZE - 1 in
     page_get_link() -> nd_terminate_link() so the behavior is also
     deterministic and not harmful to the system stability and security;

In order to verify this, you could also check the EROFS image
(encoded in gzip+base64) with a 16000-byte symlink file below:

H4sICPqj32YCA3Rlc3QuZXJvZnMA7dsvSwNhHMDx350IBotgt0wMwsnegDCYb8FiVbu4LAom
kygbgwURfR1Wm12Lf5JFTIpY9B58GCK2BYV9vvDhee64226sXPlFSBrXHu5f7k4u+isT9X46
GlHm8+9nt5tpHaxOxeS364+Wjh8PXtvP3bn9/nXvpjvq96fPfmpFLObjj7q07lzOxnq9Hubn
eLvaapa/3N8YruVwP59+Rb54IYqoqqqzsd3xZ0uSJGnsSy/GAAAAAAAAAAAAAADA/5bmb89P
I3aXv+YBiuzn/O3azF6zMD8AAADAHzHBP1qf7k2HRABQAAA=

Here the symlink is already recorded in the image (let's not think if
the symlink is reasonable or not for now), but Linux implementation will
just truncate it as a 4095-byte link path, that is the current release
behavior and it has no security issue inside.

In other words, currently i_size >= PAGE_SIZE is an undefined behavior
but Linux just truncates the link path.

So I understand that what you propose here is to check the size
explicitly, which means we need to introduce a formal on-disk hard
limitation, for example:

   - Introduce EROFS_SYMLINK_MAXLEN as 4095;

   - For symlink i_size < EROFS_SYMLINK_MAXLEN, it behaves normally;

   - For symlink i_size >= EROFS_SYMLINK_MAXLEN, it just return
     -EFSCORRUPTED to refuse such inodes;

So that is an added limitation (just like a "don't care" bit into
a "meaningful" bit).

For this case, to be clear I'm totally fine with the limitation,
but I need to decide whether I should make "EROFS_SYMLINK_MAXLEN"
as 4095 or "EROFS_SYMLINK_MAXLEN" as 4096 but also accepts
`link[4095] == '\0'`.

No matter which is finalled selected, it's a new hard on-disk
limitation, which means we cannot change the limitation anymore
(-EFSCORRUPTED) unless some strong reason as a bugfix.

> 
>> Actually, I think EROFS for i_size > PAGE_SIZE, it's an
>> undefined or reserved behavior for now (just like CPU
>> reserved bits or don't care bits), just Linux
>> implementation treats it with PAGE_SIZE-1 trailing '\0',
>> but using erofs dump tool you could still dump large
>> symlinks.
>>
>> Since PATH_MAX is a system-defined constant too, currently
>> Linux PATH_MAX is 4096, but how about other OSes? I've
>> seen some `PATH_MAX 8192` reference but I'm not sure which
>> OS uses this setting.
> 
> Famously GNU Hurd tried to avoid having a PATH_MAX at all:
> https://www.gnu.org/software/hurd/community/gsoc/project_ideas/maxpath.html
> 
> But I am pretty confident in saying that Linux isn't going to try to or really be able to meaningfully change its PATH_MAX in the forseeable future.
> 
> Now we're firmly off into the weeds but since it's kind of an interesting debate: Honestly: who would *want* to ever interact with such long file paths? And I think a much better evolutionary direction is already in flight - operate in terms of directory fds with openat() etc. While it'd be logistically complicated one could imagine a variant of a Unix filesystem which hard required using openat() to access sub-domains where the paths in that sub-domain are limited to the existing PATH_MAX. I guess that kind of already exists in subvolumes/snapshots, and we're effectively enabling this with composefs too.

Yes, but that is just off-topic.  I just need to confirm
that `PATH_MAX >= 4096 is absolutely nonsense for all OSes
on earth`.

If there is a path larger than 4096 in some OS, we maybe
(just maybe) run into an awkward situation:  EROFS can have
some limitation to be used as an _archive format_ on this
OS.

Similar to EXT4->XFS, if XFS is used as an _archive format_
there could be a possiability that a EXT4 symlink cannot be
represented correctly according to its on-disk format.  So
as an _archive format_, XFS is more limited now (Please
don't misunderstand, I'm not saying XFS is not a great
filesystem. I like XFS.)

Thanks,
Gao Xiang

> 
>> But I think it's a filesystem on-disk limitation, but if
>> i_size exceeds that, we return -EOPNOTSUPP or -EFSCORRUPTED?
>> For this symlink case, I tend to return -EFSCORRUPTED but
>> for other similar but complex cases, it could be hard to
>> decide.
> 
> -EFSCORRUPTED is what XFS does at least (in xfs_inactive_symlink()).




