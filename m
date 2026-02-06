Return-Path: <linux-erofs+bounces-2268-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eExxKSmVhWk7DwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2268-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 08:15:53 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CBCFAE20
	for <lists+linux-erofs@lfdr.de>; Fri, 06 Feb 2026 08:15:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6ljy0qn7z2yFc;
	Fri, 06 Feb 2026 18:15:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770362150;
	cv=none; b=TJJFcKkIZ6lmQ8CoSouyb/j83SZR2EzMldFv5gb3tFRxp9IMoKjSS3f78u8/oYx+rmzshJacHw5wzdQLUFIl57/mzV+b9eTc8mHzhhLzlBr9CkSVR9HqrKTOPg+31yWVmSR+nXCV9b6Q4qSZU9QGFWLj7f+YZOm2iyr49lHIE2ngqzfDfya1KBMGYJFoUgwvvwnhSlUENxTMMIl4JV0QU0+rVJ0Y1mIrk5yIDur+qhj+8dO2lZeE0isgr6A6IVWxCjL3v9mvLN5fwbrEX3r93mehYsZKS7Vgpfu4XpZ8um9Oxdktah3RVHiJ9GiqUHR4O9aTld6iGRw/f0Wi1Sj+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770362150; c=relaxed/relaxed;
	bh=yvxruQqrC5pC/cpt0tKuximBOQczDvlYdx6D878LcG0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FkVn9/FKdJKqEAhi6TIyklHFy0Iyik+D5y7m6BqIrBeOmlWDPzXFEiO2qvfSn7FzhZZUmBDHMj3tZPl6JVLRoUoXgnK5oR7cLYcSiIqEX+lgTr4KHkO6f3UvKura+cBNDfKri4GgmhZO1TE0xklfC/f0XIZ2dpehkhkV1hSh82bKnQsHJRRLEH3g+AksWWBLAb2Jr3FyHydz1yskOQi8jqhlKSnCmln3i+wNSQY7GlbwnlRS7gVx2IJJhbGkNG6I5KVi2PATOMZcuos3XAmrElOAH93E8PHnkhwHV1kXhClEkNYYqEjrDffn4633F8Mng3S9QKrimqw2yH0zRjCDAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YHheAZxz; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YHheAZxz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6ljx1g7Rz2xqk
	for <linux-erofs@lists.ozlabs.org>; Fri, 06 Feb 2026 18:15:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0368D60010;
	Fri,  6 Feb 2026 07:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAFEC116C6;
	Fri,  6 Feb 2026 07:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770362146;
	bh=4ZVaO3abGWbuKw2wFVB/tdoxncsSTd3KVe5B3yewX3A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YHheAZxzeXjECpuOZUwZrci6BUSet8VrNZptMrAzKgqgkRRleGvWW+bB4Ow6V+yUo
	 zc+DwXswW4gctPDJtfAv6QIzF9hoPIQ0EiENFbBCrOpU0DRcFQ3x50C/zsNbijGo8R
	 LvfR1BFIciU2Dm/szgO6y/Ba9ikJ5lIyEOsXUG5zXBJXdEh37HEdaHhOt72ibSwTrF
	 1wP7Jc2HTwgVBa9SSOyJqvlSwCJyyA6Rdln7fDrbFWz8iNvj/DpQx8D8SvQR2wxp3L
	 YHq8n5J9iEaZz6oMr9aLzRrn3J4dWo+xYo4ZVCF6BFDtRhug4YfXDDuN9/Cf4FNzbt
	 9Wudf22uOzpHg==
Message-ID: <712352c3-c0a1-4e9f-a689-0761e7a2f197@kernel.org>
Date: Fri, 6 Feb 2026 15:15:46 +0800
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
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] erofs: fix UAF issue in erofs_fileio_rq_submit()
To: Gao Xiang <hsiangkao@linux.alibaba.com>, xiang@kernel.org
References: <20260205223005.72727-1-chao@kernel.org>
 <9d70646b-ddf8-42b5-8015-fb54a6f24296@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <9d70646b-ddf8-42b5-8015-fb54a6f24296@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,m:hsiangkao@linux.alibaba.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2268-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: C2CBCFAE20
X-Rspamd-Action: no action

Xiang,

On 2/6/2026 3:11 PM, Gao Xiang wrote:
> Hi Chao,
> 
> On 2026/2/6 06:30, Chao Yu wrote:
>> [    9.269940][ T3222] Call trace:
>> [    9.269948][ T3222]  ext4_file_read_iter+0xac/0x108
>> [    9.269979][ T3222]  vfs_iocb_iter_read+0xac/0x198
>> [    9.269993][ T3222]  erofs_fileio_rq_submit+0x12c/0x180
>> [    9.270008][ T3222]  erofs_fileio_submit_bio+0x14/0x24
>> [    9.270030][ T3222]  z_erofs_runqueue+0x834/0x8ac
>> [    9.270054][ T3222]  z_erofs_read_folio+0x120/0x220
>> [    9.270083][ T3222]  filemap_read_folio+0x60/0x120
>> [    9.270102][ T3222]  filemap_fault+0xcac/0x1060
>> [    9.270119][ T3222]  do_pte_missing+0x2d8/0x1554
>> [    9.270131][ T3222]  handle_mm_fault+0x5ec/0x70c
>> [    9.270142][ T3222]  do_page_fault+0x178/0x88c
>> [    9.270167][ T3222]  do_translation_fault+0x38/0x54
>> [    9.270183][ T3222]  do_mem_abort+0x54/0xac
>> [    9.270208][ T3222]  el0_da+0x44/0x7c
>> [    9.270227][ T3222]  el0t_64_sync_handler+0x5c/0xf4
>> [    9.270253][ T3222]  el0t_64_sync+0x1bc/0x1c0
>>
>> erofs may encounter above panic when enabling file-backed mount w/ directio
>> mount option, the root cause is it may suffer UAF in below race condition:
>>
>> - z_erofs_read_folio                          wq s_dio_done_wq
>>    - z_erofs_runqueue
>>     - erofs_fileio_submit_bio
>>      - erofs_fileio_rq_submit
>>       - vfs_iocb_iter_read
>>        - ext4_file_read_iter
>>         - ext4_dio_read_iter
>>          - iomap_dio_rw
>>          : bio was submitted and return -EIOCBQUEUED
>>                                                 - dio_aio_complete_work
>>                                                  - dio_complete
>>                                                   - dio->iocb->ki_complete (erofs_fileio_ki_complete())
>>                                                    - kfree(rq)
>>                                                    : it frees iocb, iocb.ki_filp can be UAF in file_accessed().
>>          - file_accessed
>>          : access NULL file point
>>
>> Introduce a reference count in struct erofs_fileio_rq, and initialize it
>> as two, both erofs_fileio_ki_complete() and erofs_fileio_rq_submit() will
>> decrease reference count, the last one decreasing the reference count
>> to zero will free rq.
>>
>> Cc: stable@kernel.org
>> Fixes: fb176750266a ("erofs: add file-backed mount support")
>> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> Thanks for catching this:>
> I will update the subject as
> "erofs: fix UAF issue for file-backed mounts w/ directio"
> 
> to make it more clear about the impacts.

Make sense to me, thanks for the review.

Thanks,

> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks,
> Gao Xiang


