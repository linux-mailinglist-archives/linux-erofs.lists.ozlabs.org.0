Return-Path: <linux-erofs+bounces-2777-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D/ONMfauGmjkAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2777-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:38:31 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D111D2A3C6E
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 05:38:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZfNL2vQ6z2xb3;
	Tue, 17 Mar 2026 15:38:26 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773722306;
	cv=pass; b=imuJ2kJL+HT2z8/jA2wyoc4LSormifqix8MY4fqjZw/UOyznTPIa6hLJYF/XEwHBPFo+h5w47liLSx/cbk8ONSd2dxW63rRa2TeFxUy58joD9e+DwBxz4yq6jOtstrtGrv2T6xwL7dh6DDT0ntH6gX74f+aIDeRV4CW1J2f/EKczzaPf32lghWzegaNkECmo1DrAUnArfhL12a76KCfTm0ZQzIENaQ8VGDvAakPBLus13/YGwK5ZnMAv5iELC38f20NwAdQ1DeQnKUwGprcW7L3AgZgaAqcgYcL3UP3jFqD5NQBsps3EK5nrw2v93wBXBX9depCD848CsBz4+rovgA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773722306; c=relaxed/relaxed;
	bh=HKBbmNCvB2LrNip6gRves+F53CKo9SOHkw61wTb8OkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hda90IPMPoquVQBGTW/zpRdws6d8rFEqqTDJz/9T4sxGyKKB8wmhc60p3PCfHAuOap0P2cdZOu3XeViGy04BSegGq3K2xzN1neqQpRzcRtZl+vIi1DblRRGGD45lM0Qhjv/4HbiaFn36j8fRPqcXmRiSt7pIrf11UwVWLxBqB1X7qXYqr2XTUsm7uceBLk8LoX2PPvKGgdZ6VMZPVUUCXjyCHku4oZIUmCuvGL493KOZI8fEJObcQnmXrw8mdefkD6U+zhAPdyq3oLRREm0aN1xzDNS9NxCABeojpUZ7Oe/DYhGkFCSqv94anH5zRPP5Pg79ndm3hM/Q3DCrUWIWsw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kLLXXSOw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kLLXXSOw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com [IPv6:2607:f8b0:4864:20::b134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZfNK3MSLz2xQB
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 15:38:24 +1100 (AEDT)
Received: by mail-yx1-xb134.google.com with SMTP id 956f58d0204a3-649278a69c5so4661961d50.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773722303; cv=none;
        d=google.com; s=arc-20240605;
        b=Mnc6ZD9Aeq18SEIQLaFnA2Q6DTlm1g6us+mSJKzkiO/LjBLnu3AiBNiJA6ghfojaJe
         6ihpngCStN6jlA6/x8MvJ5CFJI2x5jiWuTO2zCIXyiVahMAdSWcG3F6Z24BxrdYXjW1z
         LeJc5o+VhamClSQHvV7M9Y+2zyA/+10fAjIh4tyB4WD0qe5jbo+y+k8rwSz+qVJoakGv
         UnHEahbBCXK9jyrd8OghJ83pjYIHu6S/YtoKsd7fsHf4ygD23r3MQHrMZCdapN9MHWFQ
         rJ++WO550JaDdf2v6lrA6+tG5j1lKZsmrrytPX4K8SXz/A4hgdUeXHsQlC+q3TYNBfzH
         asQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HKBbmNCvB2LrNip6gRves+F53CKo9SOHkw61wTb8OkQ=;
        fh=fGi08w/4a1MljzhhKsvJYLwkoHf7EUz6TBZsuO4DFJY=;
        b=KzX2OZHnIuL8PE3sI0Ce7a1FxqguHCTwGBeBsiPaY38+GdBc4KVOcIGxNrszdPM9Ak
         y4m5ZFpgsandGUybmxOiEErU6/PS/b5aNQryWYEoQX6ziMHbE68r2xa7270TZ5zmYxua
         qZcWjPiFSaxrAhnHoAbPvmn8CXD/t8yhwKhODMqkqa4KvV+S+9bpdWWjYIf+VvyPIbnd
         oFaSy5t/uXxlwrv3kN3Es22geYVKyEM3YmGnpbvLsfNMx+B+3uUM8flBMydL9wt6hN1i
         JHtXAMIPuIUPZRykArEYRuze8kh8krPEH2xO0Or2kHTHEcKCiu0fHXKe6zY22Tzt3BUz
         hiGw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773722303; x=1774327103; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HKBbmNCvB2LrNip6gRves+F53CKo9SOHkw61wTb8OkQ=;
        b=kLLXXSOwAE2AuecIdIpo4I6RQFU1zXPe1IWECT3oW2rg5Z4CLf7KGIBONW2u1c92ej
         ZoEbsxnXbvJEczgbBUt+QIwojfiB/cJnWrbCMgAXpm8gh1WDPi95c1BA7/V2Y8ehhslD
         km9SsUQ2ApATIsAKx/B/7aHAV8LiEtXn1OACVW5yWEJ3pqXW5GXNbcWyKo1//lxAMNtF
         Us1phj2zpuF1+tdkjZz0OWaaWpaTJthrnTqwDLA3Tw6RFjH2vRdRHuhRvi18nCOdSWMQ
         ajSyIiVq56bb0Z/+5NnBsKCAPRL/TuHj/iKUPplYNtBC0zNwSW8GHeYaxNq7n9a355zt
         9HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773722303; x=1774327103;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKBbmNCvB2LrNip6gRves+F53CKo9SOHkw61wTb8OkQ=;
        b=p0a+vP2btNiVw9IctJaNxEb8KZd4Pgh4Vkw45WjNPrxo8p5aNAs5MMfel+12uR1XDk
         Fn7BXhDKF9jU46dazokYupzTuxMooHmTw1xJvgmYI0woGIbfKQO5QteL/x6iWWGrd1U4
         dpbt+ZFNfcJWCyQ2c9W0xEOUzwhS6Y4tsUMByvKY1xsvmWFAyTCLMi1mUih+293+HRXw
         lSZUV4ITvpooyBlqga68/eCnt3/EQH9AU7GEJgf5HA15Hw8ZsOmyZBSJKc7EfixYG816
         fQqpXzrE60trcBoqQe66BK2+5ARqYQ3l/eOsxKFP/whzIHJXsQAgmAKnwYNqK/nzkwE2
         Py9Q==
X-Gm-Message-State: AOJu0YxjO6yr/sTmm0I04jyPQZQYqaoDTNjQ+6dd4smn03Ldt7B3uv2+
	9TFOZg5doTbak2pzniNNthhOTVV+UtKt10I+PDYqQGuuKuyS08QOyOtf4/03I1QvXFctKXrTFBP
	9AP6r2uRmhTzsqosmSxF7GCQvjS4fAZhjzBZGDis=
X-Gm-Gg: ATEYQzwSPez/uC+Ozw2V9DJeUzYSZIm8YLqyJfUXIC5hyfqxEmCEmlAXF1bcftrKx59
	jYkqNFP5IweQ2iUG/0lSzfQxfDVolpJXGLPo9ij/4re7yhH4f4D6cjrOhoqrdPhMnTVhz7fpyar
	Xl/QBr8JMzKCntGrt3pxMTcHZChJcuTHNd/pgr70BP4ANRloP7UAZAqO9htlEboCYl3RxBsMOuj
	BPyOlUoDuHHhhtLIQhDzAQXRTpu+PNFkUd6ovFtp70e6f2lCs112QQROR/aX4FSCSGcw62eW57e
	CaR6Lbo=
X-Received: by 2002:a53:ebc6:0:b0:649:c6d4:898a with SMTP id
 956f58d0204a3-64e62f6bcc6mr12208863d50.28.1773722302674; Mon, 16 Mar 2026
 21:38:22 -0700 (PDT)
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
References: <20260317043307.27575-1-nithurshen.dev@gmail.com>
In-Reply-To: <20260317043307.27575-1-nithurshen.dev@gmail.com>
From: Nithurshen Karthikeyan <nithurshen.dev@gmail.com>
Date: Tue, 17 Mar 2026 10:08:11 +0530
X-Gm-Features: AaiRm51ddIIsXHwnyRKeeHVGUu-G4jkHqAbZv1OHn0E8L20HqlAxoVBOTHqAKcQ
Message-ID: <CANRYsKjO_QJdemxycEqxRF9qOJM-E6F2MggkxiP6+tHicrPpgQ@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fix thread join loop in erofs_destroy_workqueue
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, hsiangkao@linux.alibaba.com, zhaoyifan28@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2777-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: D111D2A3C6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject: Re: [PATCH] erofs-utils: fix thread join loop in
erofs_destroy_workqueue

Hi,

I have submitted a patch to fix the thread joining logic within
erofs_destroy_workqueue. To ensure the robustness of the teardown
process and guarantee no resources are leaked, I performed the
following verification and testing:

1) I built mkfs.erofs and successfully compressed a test directory
containing various text files using lz4 compression. The image
build completed successfully without any hangs or crashes.

2) I ran the same mkfs.erofs compression workload through Valgrind
with --leak-check=full and --show-leak-kinds=all. Valgrind
reported that "All heap blocks were freed -- no leaks are
possible," confirming that the modified teardown loop correctly
frees the worker array and other resources.

3) To ensure no orphaned threads or synchronization issues occur
during the destruction phase, I ran the workload through Helgrind.
The workqueue teardown sequence executed cleanly. (Note:
Helgrind did catch a pre-existing benign data race in
compressor_lz4_init unrelated to this patch which I am happy to
send a patch for).

4) Finally, I ran the built-in ./contrib/mkstress.sh script to verify
behavior under heavier loads, which also completed without issues.

Please let me know if you need any additional testing logs or
further modifications to the patch.

Thanks,
Nithurshen

