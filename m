Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 30121617B7F
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Nov 2022 12:30:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N31lj10zZz3cGc
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Nov 2022 22:30:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=leemhuis.info (client-ip=80.237.130.52; helo=wp530.webpack.hosteurope.de; envelope-from=regressions@leemhuis.info; receiver=<UNKNOWN>)
X-Greylist: delayed 1301 seconds by postgrey-1.36 at boromir; Thu, 03 Nov 2022 22:30:33 AEDT
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N31lY16g5z3bjd
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Nov 2022 22:30:31 +1100 (AEDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1oqY5Y-0006kG-JP; Thu, 03 Nov 2022 12:08:48 +0100
Message-ID: <9114cdb0-9d2a-d863-9157-40f182b110a8@leemhuis.info>
Date: Thu, 3 Nov 2022 12:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220915094200.139713-1-hch@lst.de>
 <20220915094200.139713-4-hch@lst.de>
 <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
Subject: Re: [REGESSION] systemd-oomd overreacting due to PSI changes for
 Btrfs #forregzbot
In-Reply-To: <d20a0a85-e415-cf78-27f9-77dd7a94bc8d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1667475033;417961eb;
X-HE-SMSGID: 1oqY5Y-0006kG-JP
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
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 03.11.22 11:46, Thorsten Leemhuis wrote:
> On 15.09.22 11:41, Christoph Hellwig wrote:
>> btrfs compressed reads try to always read the entire compressed chunk,
>> even if only a subset is requested.  Currently this is covered by the
>> magic PSI accounting underneath submit_bio, but that is about to go
>> away. Instead add manual psi_memstall_{enter,leave} annotations.
>>
>> Note that for readahead this really should be using readahead_expand,
>> but the additionals reads are also done for plain ->read_folio where
>> readahead_expand can't work, so this overall logic is left as-is for
>> now.
> 
> It seems this patch makes systemd-oomd overreact on my day-to-day
> machine and aggressively kill applications. I'm not the only one that
> noticed such a behavior with 6.1 pre-releases:
> https://bugzilla.redhat.com/show_bug.cgi?id=2133829
> https://bugzilla.redhat.com/show_bug.cgi?id=2134971

Great, the kernel's regression tracker reports a regression and forgets
to tell his regression tracking bot about it to ensure it's tracked... :-D

#regzbot ^introduced 4088a47e78f9
#regzbot title mm/btrfs: systemd-oomd overreacting due to PSI changes
for Btrfs
#regzbot ignore-activity

Ciao, Thorsten
