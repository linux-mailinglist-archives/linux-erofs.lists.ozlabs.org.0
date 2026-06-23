Return-Path: <linux-erofs+bounces-3730-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hSrgIrv4OWpMzgcAu9opvQ
	(envelope-from <linux-erofs+bounces-3730-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 05:08:43 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1786B3B80
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 05:08:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="bte6f/g0";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3730-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3730-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkqlW1ylBz2y71;
	Tue, 23 Jun 2026 13:08:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782184119;
	cv=none; b=Z0lsCz5ESUWeqECJ/7lrljWu6wpjJS6OzGcyPI/5xtKEuleRKOrcmJdW9X6kDKu7F+XBjf+SrVoni/tDNRWSHCqeQsyc/WP9ZaA+/kz8KOw6jkrySh7RjARiZDgj8Z7MNmbz7Ix9JBHdOHmE7rrUnq4/65WKc81c/Dtc1RSVJDBVf38BjdSpDNiplNCU0Ib/hsbRpIB2AMYexoXmoSff2byuwIZPzAXwwyjT1OxEXNm0eHHDU6dBOQaMZ/QEGs+heXYgtKrX6iLmR43fJQL7FQKVtSDZyamMSq9ewUlEJx7z/p68gwMMjMhSJIRz311Db2Vp7PUCwCR733A1BYYPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782184119; c=relaxed/relaxed;
	bh=zHiDri9KzHNlCTTPg63+52RFsjBrh001hiLblpMgP9A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ztz4D8WNC4Yuf3dMUWWF/7aHgaSsdnW1eoIzZ5M6jBGAgJlWUYs6KS/mDLp0D5ONB3ft9SnB7CXNci6b5y3UAKCIpF1j/rXbr6zDY358Ah+SrqsBZHcVmm8xiZwQ5oztk6qt44FzN/PHuiJMggjL7eUgUtUugTAUzrQ52npVEcFSbeMg4/6INVGI9XSmA5yw1U4FIWutSZqdP7UxOmZuDi0G0VkkhF/2dthGQ/XiwnVNLo/XCUPLT1ZL1sUaxAV/niw48pcrXUPz38P7B1Y9sfrtr1gpldDzDNDIHBhc5rM+lDh8PbNsJw0NDOj/nV8KmiitPY7cfw9vD/xk78eMgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bte6f/g0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkqlT09mKz2xwP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 13:08:35 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782184111; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=zHiDri9KzHNlCTTPg63+52RFsjBrh001hiLblpMgP9A=;
	b=bte6f/g0Wf3HRQUPpBmtaj8BanNj8OpvR7JWSuP3jTvwLHNFjCrYMFkdZTK4OlxpKbn2xVD9TW1C6BBLnyiQr7N0OHPjWPXEJPWnwcKOhhGN0PlobyuAtMQJAZta4CFD6KRBmemOHDaVYcCaLKGA2z3LcY/v5QWExytwwUJso1s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X5SX67O_1782184109;
Received: from 30.221.132.85(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5SX67O_1782184109 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 11:08:29 +0800
Message-ID: <a5230f86-74af-4fab-8806-a118a0cf3a98@linux.alibaba.com>
Date: Tue, 23 Jun 2026 11:08:28 +0800
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
Subject: Re: erofs: is z_erofs_put_pcluster()'s sbi access in the same UAF
 window as 1aee05e814d2?
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Jianan Huang <jnhuang95@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
References: <20260623024946.3420476-1-zhanxusheng@xiaomi.com>
 <0e2df016-dc1a-4dc5-8461-5a778f029247@linux.alibaba.com>
In-Reply-To: <0e2df016-dc1a-4dc5-8461-5a778f029247@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3730-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.ozlabs.org,vger.kernel.org,xiaomi.com];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zhanxusheng1024@gmail.com,m:xiang@kernel.org,m:chao@kernel.org,m:jnhuang95@gmail.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD1786B3B80



On 2026/6/23 10:52, Gao Xiang wrote:
> 
> 
> On 2026/6/23 10:49, Zhan Xusheng wrote:
>> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
>>
>> Hi Xiang,
>>
>> Following the race model established by commit 1aee05e814d2 ("erofs: fix
>> use-after-free on sbi->sync_decompress") -- i.e. unmount does not drain
>> the async decompress kworker, and unlocking the output folios lets inode
>> eviction (truncate_inode_pages waits on the locked folios) and thus the
>> unmount path proceed to kfree(sbi) -- I'd like to ask about another sbi
>> access that also happens after the unlock, in the same kworker.
>>
>> In z_erofs_decompress_pcluster():
>>
>>     erofs_onlinefolio_end(page_folio(page), err, true);  /* unlock */
>>     ...
>>     z_erofs_put_pcluster(sbi, pcl, try_free);
>>
>> and in z_erofs_put_pcluster():
>>
>>     if (try_free && xa_trylock(&sbi->managed_pslots)) {
>>         free = __erofs_try_to_release_pcluster(sbi, pcl);
>>         xa_unlock(&sbi->managed_pslots);
>>     }
>>
>> So in the try_free path it dereferences sbi->managed_pslots after the
>> output folios have been unlocked, which on control-flow alone looks
>> similar to the UAF fixed by 1aee05e814d2.
>>
>> What makes me unsure, though, is a difference from the sync_decompress
>> case: sync_decompress is just a plain sbi member, whereas here
>> z_erofs_put_pcluster() is still operating on a live pcluster that is
>> registered in sbi->managed_pslots / the managed cache. So it's not clear
>> to me whether the pcluster / managed-cache lifetime rules implicitly pin
>> the filesystem instance and keep sbi valid across this window.
>>
>> This also seems much harder to hit than the sync_decompress case: it is
>> conditional (try_free, i.e. non-managed compressed pages, plus the
>> pcluster refcount reaching zero), the window between the unlock and
>> put_pcluster is narrow, and unmount still has evict_inodes/put_super work
>> to do before kfree(sbi) -- which may be why syzbot didn't reach it.
>>
>> Is there any guarantee that sbi stays valid here after the output folios
>> are unlocked (e.g. via pcluster / managed-cache lifetime or RCU), or
>> could unmount race with this path similarly to 1aee05e814d2? I'm asking
>> rather than sending a patch since I couldn't convince myself either way.
> 
> No, this is totally false-positive.

In short, I saw some similar report from LLMs, but I think
erofs_shrinker_unregister() should block this from kfree(sbi)
by design.

Thanks,
Gao Xiang

> 
>>
>> Thanks,
>>    Zhan Xusheng
> 


