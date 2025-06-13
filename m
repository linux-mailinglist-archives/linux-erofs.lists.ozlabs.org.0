Return-Path: <linux-erofs+bounces-401-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36079AD8BDE
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Jun 2025 14:16:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJdg66vfjz30Sx;
	Fri, 13 Jun 2025 22:16:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749817010;
	cv=none; b=SZUD53nFGlXuCd/a6D290WgbTxfFyDy+BXLh1Bqfj+8ZS1UlwLmcSCdhAPzds/E70xmQCO4CiiP7DIsPPdGMjqJzEnZ4p3cvPB/aR2hYsSKr3KaJtxYOywbQKSVAsyPqoKUpbjH+NjdvFSk6X1OymUGjswMeBSxlhlB6bMnk+s+pbkt8l5it+ltPkeU1o7PMXUER08DCGvSpkME+MIKrqqt0D6+o2P6Cn23KIjFiAUWgcKDRj70BykJgxgrL0xbvhLqME/TqCOznvWj8ScZBOpVZwhjEZH+viSRXS/l7s/7A1fQnk0i176QX+fja/LnrKe7M+GgsOOU7NygmEcSh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749817010; c=relaxed/relaxed;
	bh=SfoIr08rFFEuKJXvO7anMKrnwyitTK87jSRVy8mAH+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hJ3tXVsD//VwTkAyR3AL5hfqnMC4MlLeOFsNTVmo940ruX5T8agSPpKX2ZB8edxYrb+0/ZkYmGEWaFurXJB9GctvejQoV3f1NYV6GfpJ8EWgcoMXgEes5eRVlSC1vvb3N7LyaATqVOMc6PfmQlXnupKH1jDme3JHSKoYArWnVsBBJ8tHbge2jPTh4yAileM/FdLxKlPC142WJ19d184GXH6o6xWa/XB9gPtUbfTAYtgd7JLa1qpY6T9FF7P+Tpp7RvyrB6xH6CLMeA8HmlwScJrY9d8cvGloi1+GtivOsG6AeVRAIih0PcKat2M+7YYeFx64myVPJ1hCHFEVP8isCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass (client-ip=216.40.44.17; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.17; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJdg62lgSz30HB
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Jun 2025 22:16:50 +1000 (AEST)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 7391616041D;
	Fri, 13 Jun 2025 12:16:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id A68BC20010;
	Fri, 13 Jun 2025 12:16:45 +0000 (UTC)
Date: Fri, 13 Jun 2025 08:18:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org, Gao
 Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: Unused trace event in erofs
Message-ID: <20250613081822.12e55023@gandalf.local.home>
In-Reply-To: <20250613081728.6212a554@gandalf.local.home>
References: <20250612224906.15000244@batman.local.home>
	<0baf3fa2-ed77-4748-b5ee-286ce798c959@linux.alibaba.com>
	<20250613081728.6212a554@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A68BC20010
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Stat-Signature: m6udp5jjwegyfd1fdgkg9u4nwyp6sj8y
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/YlOrz9rks9Xb9kZ1ETrQ3G/D/yxbpkjw=
X-HE-Tag: 1749817005-7527
X-HE-Meta: U2FsdGVkX19UnAUqeEpj35VQFLUlVpMOFJ+N+8y0g/XHToHOaa3gINOQWFY5FEcon3recYuI1u1W8jDnXUKGJBhc5p6PrWy1qk7uT/fmr/e+9iqAY97YwkmWkazLX/wvIygdtF7/hkvVfX6+m8Ny3eY0cRYoEDCOMx05DjLFzQM6it6KpC1lIh2L54TJYQWo9+8praYknIKAMvjdYGIFTO3npXmjBgaFnKrTsC4kwoVsgWVDNx4RsVAszXTBSjKoZzCFGWGy2scRrsh60aBgkQN+l3HYDY15MG7ebC7K92WB4LhyYgSjOfZW0JfO2X43zXGj6zcq9sXsK96htK0v0+A4gYkIEL2J55bWFCvlxD4AYi8ix7Btf9+eCSnDLv9NOVAMsZMUnpvqeaSt0th3Iw==
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Fri, 13 Jun 2025 08:17:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Please make the patch. There's too many for me to do them all.

You're not the only one with unused events. When I said there's "too many"
I meant in general, as you only have one ;-)

-- Steve

