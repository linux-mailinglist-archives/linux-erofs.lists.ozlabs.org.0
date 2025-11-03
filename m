Return-Path: <linux-erofs+bounces-1345-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64247C2D0C2
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 17:17:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0cDG2pjKz3bf1;
	Tue,  4 Nov 2025 03:17:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762186622;
	cv=none; b=TCoPFwOM/8pBqjGaq39ykPtU2pcBMcCxOptBANsMe6cjOSuD+F/CRNL4TPWAa5Xk8+NRNWAz2StGw9gBdvk1CKhBk31V8p5xMqD76+oehn/tEodoeaDw5az1/xUQmzryc3Rgelet2oTiKBqqE31RZ4qeN7wPd4/vxpFokZxnvpRTLiHpgWUKqd6SDOAjLrDXAulpNLM3KVlIz8me1tWQnmhdQ9Ec32WuTQ1+LEa70xmvJeAJjyDLd3nZnst/waaYvbZZONriOx0Q/y6Mce8OuJHsexJCy8XF8j6UMhJ8EpAETd5He4+ypfNLJEfZWkrkxqTzzIXRDqDwBS7xpq+npw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762186622; c=relaxed/relaxed;
	bh=wGNiHtYjUIm5b0l1N3TzVUE4Xj4QqcbTdAE9xV61Y0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea85CnnqnIVU0W6LZBYX14irFGfAgcq3McJoXh552WtJ2l8m61K/wgvHB16rtA3Y1PrfP7Qf0Z5WF1zTxc8oSeM+45JFkz5I0s8BMeuYTkK6jRqr9RIINiue5rC8PHxY1h91pMVnQDjsCsG3q5MbvQU5H3E6N7va9JJbptVKqMFseNcW9lcbILK28nMLwb+QPF/wH5Yj6+vEdAoEe9ToNq6384ibiTEpW+T0tB9Vb5WL+ATEmJN5CjWhhfnOwwDfdJYq0AxJ/UqlYIQYv9RlB5A9MrqpoDwjUxYC4Y04TuVDM+eInQhrvAwdPtxoeTNoY1zRQfv6zQbv+G8vTjifeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass (client-ip=216.40.44.14; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org) smtp.mailfrom=goodmis.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=goodmis.org (client-ip=216.40.44.14; helo=relay.hostedemail.com; envelope-from=rostedt@goodmis.org; receiver=lists.ozlabs.org)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0cDF5w9vz3bd8
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Nov 2025 03:17:01 +1100 (AEDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C84CD12ACEE;
	Mon,  3 Nov 2025 16:09:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id E4D1E20024;
	Mon,  3 Nov 2025 16:09:42 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:09:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] trace: use prepare credential guard
Message-ID: <20251103110946.063f53da@gandalf.local.home>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-11-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
	<20251103-work-creds-guards-prepare_creds-v1-11-b447b82f2c9b@kernel.org>
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
X-Stat-Signature: f3a1jbh7gz5tygnr9ophixt6pum6i47w
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E4D1E20024
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=disabled version=4.0.1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18u0U/NQFwhYc5xAY2TcmGwcG1D2BgWoTc=
X-HE-Tag: 1762186182-249034
X-HE-Meta: U2FsdGVkX1/oN4yafgD+MyqaAV3m0VoVtYRzu0D3nhVrjp7q8uA8Uc/g3Y1973pDGRtBMJFIpQ7B0O+F37rmbF8kIjhS7YPoQfvuYhqXbP66FkjkDqcxlSq/f9rE0VLfodvjXBeCq8tk6S9A50kqMRPnFBqoeWWggpvhArKEUJcxWbwhtGBUJA9D9GDy2rYSO7wzCitOaHdm8UT261o9vVM0wBxFfhfhIDvg4yDkUhUWC4l4RdGwq0vyz6roxCpZv5oWzdyX4MkQM3lYByyuZonkzkJpT2nT1UIISYlOxhoA6jv36VwIlmUVdl8Rp2E7rl7MGO6o9ABv2Rp0ARVpE/1Y8CPdK53RazVlow3RlyHTtAdeg3sjiAKEZ+dX7QrpdQ7cwXCa90kYxiksyJez7g==
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, 03 Nov 2025 15:57:37 +0100
Christian Brauner <brauner@kernel.org> wrote:

> Use the prepare credential guard for allocating a new set of
> credentials.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  kernel/trace/trace_events_user.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

