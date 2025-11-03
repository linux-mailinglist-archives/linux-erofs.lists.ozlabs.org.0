Return-Path: <linux-erofs+bounces-1344-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B546EC2D090
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 17:15:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0cBp4SB0z3bdf;
	Tue,  4 Nov 2025 03:15:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762186546;
	cv=none; b=Dd6dt3rLPRD/S/9ffx7c2NG4W9Ie/6vxJO1HUcTWf89MW1lBJ/v1Pys7G15QTR5lYcfKcX1tr+hWq5z8K2aBiJJ9V8YjBinZlyfTg9hABChetbzzwxlj879f58nDBGx5578vlemrWEXHO+jwMOLs5bl5p0gS7C0B5+sJh0j7QpKFiVE+h7SITdOb5f8wsFDwsF80cYfs87oKDKI+OIR0uwoFxGy/c5MR22svGDmy1NoTBIWM3HgKzwBCRS6IP3wmsaadnmo11BA/zeO10y7dJNJ21JA8s0jXbGQ6oUtrXOGQ4NpQI/UflD1tz+b7rCgbcJiLu7rv5LMCHmmcjzopDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762186546; c=relaxed/relaxed;
	bh=nx/co0UY9blrlir6NoykewZukqopHcwWOdTQlaIaDPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFt0rhPAS3XpvLO4tXLc8x4MJI7QJ+5sZS6PqBoHnp7f3klRyGlI2lr8jJfCug4yDnchsvR5kJvjlm2h2BqZUDUujokzX+I48P3oQfqXrOac11xN601n4Lr8UlgtaHHzh64w4v0T2LpRrARRUf72+MpnxdTWZL98n1p80kZbSO3x0OaJ49MThIjc6lJ29KzzdVBUCeYHR/jKfc/L4uxiQU4mORXS5rw/f5h0g+dwIBFy2STe3lwDg3+usCArriTnhexFBHpNTlkA8+r2dFuQGI16rqgdsW5lCXJmwF8n1gR7YKLbeal3v33qgHfXBnRCr3gYbmpdTdtyDQsVueT67g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass (client-ip=216.40.44.16; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.16; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 353 seconds by postgrey-1.37 at boromir; Tue, 04 Nov 2025 03:15:45 AEDT
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0cBn5b6jz3bd8
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 03:15:45 +1100 (AEDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id ACF47139E08;
	Mon,  3 Nov 2025 16:10:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id D4E0A20026;
	Mon,  3 Nov 2025 16:10:14 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:10:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] trace: use override credential guard
Message-ID: <20251103111018.1a063e6f@gandalf.local.home>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-12-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
	<20251103-work-creds-guards-prepare_creds-v1-12-b447b82f2c9b@kernel.org>
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
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D4E0A20026
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Stat-Signature: 9i8cwffmtnwb5s6qrjb8xtgzkiwywx5n
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19W/8xN94pNILmfZfTWKaYA/3XQ1AXwuhQ=
X-HE-Tag: 1762186214-326372
X-HE-Meta: U2FsdGVkX187oVSDRmUrDkx/y/qOH8UZf0p4/Uberk79CvGGM3PB+bS4hFQMtMBRnStKU7tlXn/ljHIltb999OspMxf1AbgAdGJ4HELAt2d5MaZ3fPZKklFy28lWO7r0IfW2NHvpDWpAzd6euKudbGYI+fHpMHhDMkXFuPEqjUv0+MRdLzcQFruKvrL4Gl9DwYesxzucXQGzI2pHTBcEz6bFpl9Bi1TKKSPcL3Nt+jnhVL/ZY4VjnpDa6O+uTo/zuM+YOrGhZidshqQRODml/FXmO4hQP0LvRRP2OeH65EderoO+6Iw5sJs9vuJe8U2RHjqtb5RfJ+b+TBT13gA7yEo+MTIUsNTsghvG0w3kvqWdz/+jfR9m7Faf4VcYB3h/KdOAB3mXHBvjf7jof/ORBw==
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, 03 Nov 2025 15:57:38 +0100
Christian Brauner <brauner@kernel.org> wrote:

> Use override credential guards for scoped credential override with
> automatic restoration on scope exit.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  kernel/trace/trace_events_user.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

