Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C9B703D8
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jul 2019 17:34:22 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45slyf6DVmzDqV2
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jul 2019 01:34:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1563809658;
	bh=56w6TCZwWdg0zVIlpzB9ayAe/Z+9TXBQmMV+gRmuVw4=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Bj1St6z2MchV2KlrDXLIGCaIMbt1qPgHr8UWXH2HeQP4+ID/mwAKE3+ix8i38M77i
	 oVnMkVWj3MeSAdxvJwrjLJQwiG4Qti45dIQMxaQ9zCt4ml5Ff3B06n2XfqI0eB1Bpc
	 aIcnDWEAG30G4Mr+nsaEzSyRkqrkiuSiG+vZvXNGOQT3UxVtrwOoH5UHgqtXY83YSz
	 kUZmyoC39HaSkxOK5WRIe0MbD+HdW+aC3hstUkrSQ4CHcwV2CfPV9JTsVtE4l3BFHu
	 5wd9plGH/BAAV1tJFEWoLeuqxWnC8MdbBQmw0TAspz3nswQsQdPSsQX5VGOQ//VqnF
	 XKDx7NpH0o1cw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.65.30; helo=sonic315-54.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="DxrhCFr0"; 
 dkim-atps=neutral
Received: from sonic315-54.consmr.mail.gq1.yahoo.com
 (sonic315-54.consmr.mail.gq1.yahoo.com [98.137.65.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45slyZ1Bt3zDq99
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jul 2019 01:34:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1563809646; bh=EOZah5kUC13bHcvzbSgLDufxhi1Qe63umVH2WdpN0zc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject;
 b=DxrhCFr0vEoGtuPSEwDUdKRq/z7am8XzmOEhxBQ5CcF7RRdcXbRXHw624852DQZYTJCRmVqL0XFOFwOMQjdmeIeaGqcZNTAd52g7yER4fSvvdjNwvFKqakZlgxliCe33kGPCgV5N0QiTNu85lWiKOlZ5eXOGa9xeC1yRd5rjpBPvUeSpL4GEaB2acJ7Gcbpw3ul2ZioPNlRleh8p/RBjpDTHwcrYre3BgNcY7D0LUj1PUongw01Bb/M+enFkJbM8S1R8sOT09nwG65+h4V055QjdmnNXJMWrgUpHonWrMkqkqHhwAJ9qN+t0muS5IKvgY4dPq9m2radPwtvZbOf1MA==
X-YMail-OSG: npDf6yEVM1l7Au6.Y9Yh_F.QhiCu80KA5a5gBgLLnq1JMpXQ8nbGuncLU.ihvVs
 6Q0yj9DSCBoNXyHCMiky2sHeXEzdNdrXblp30TLaWVW2R4twm9RDb82qGFnlJmCMyykggZTveFAS
 hoeOrUfypJKcIoaCkRO939wBppDieXbeNiLA0e0v2UCySWVRjtqun6uVhCfwiCzizTtpFrJDPXix
 AnHnPotG6JJ4nw5scbOcqzIEsqBEhtXvPzP6IQKq6nUqOGMTEmKZL1yif1Nhkgcu1DCQIcjSsD6o
 YjMbQwsb1M8OvaYfS0H5DCyp_zxgy55vcT.4wH8ywzZqcQulh4n4AK1TwWklOn.06WF3tp4zfAMm
 xnCWKvtZ1VymMxZqcht9D2ZMM9FiSA94JgQsP_0GRdz6n_OUEK3qGQToV9d4OihZm0Dh4pFx2tRz
 1cKRxnO8xzq3JrUqoeHGG49NsyiVOLDZqQtO7WyvYAzdxKnwea.hFpddwUXVV5bhTAQ4OHK2wJ4L
 bADYE6BZfEUVLJlTkGzRWK9ieZtwYZKx8iqorSrof.yONKWselSGlX9MT16UGc8JHb0J0lEc4i3E
 JeRRvayuQb74P5Rfqb0SLGrhewwXr6yRqUDX7SKH9.REnopvMEBElllg.8q02NNRVk0EQRTFwvyJ
 Tnkk6lfDJU2oHQARdJ9y.jijtVf.WBMXhkI4FZOu70u63CY6S9s.hicMwUxa5HybU6xt.hJ5lmDn
 Ush0VkPYJpl5MZ7pBkf4omcfdTBvf5vFkJPYa2UiFuvyYgFrfb95XpB4Flt2Htn5O8Jge0sZNuRo
 mg5qgdLxlPE4BBBuam28749g6L0dJAk2oNUThJaaknYZ_DTFF_2Qen5KWvrJ26U35FoLa2_idsTT
 rMG3M5E5Jg1GAZbVJnV7I3am6.KQ41Wn5KU4RitPSg08ZmwGTspQjWAFj.aDrGx0OdIMa02sEqZ8
 zumJf7lvMJzZOlfitRgFSD0p0tjWdsqDoPDnIEcUOM4IwN6_6pJYSvnZxeCj9sRyc3y.LR2PfApp
 6gxE.YkwFRl5tt7bep8s2idFnrEzKSdUemabNWb3oel3ELwpL38YYblKhnACGk06XBvw9fPdOO.r
 ly3EY3DVgBCl92GHVbypxGep.W_OJm6q3j.JqzFvMqoQbV_JkPzcNo7PPZZqxrdnUJEwG9pfe5OZ
 xjnWCXnGGAyHr_eth18VYfXJVcnOiHmBLxiiGDnoo6qnkezzmKh7vSqEXLtvsDGdRwA_pXT0-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 22 Jul 2019 15:34:06 +0000
Received: by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 7d543092b26e4fc618ecf41b7b8d639f; 
 Mon, 22 Jul 2019 15:34:04 +0000 (UTC)
Subject: Re: [PATCH v3 12/24] erofs: introduce tagged pointer
To: Steven Rostedt <rostedt@goodmis.org>, Amir Goldstein <amir73il@gmail.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-13-gaoxiang25@huawei.com>
 <CAOQ4uxh04gwbM4yFaVpWHVwmJ4BJo4bZaU8A4_NQh2bO_xCHJg@mail.gmail.com>
 <39fad3ab-c295-5f6f-0a18-324acab2f69e@huawei.com>
 <CAOQ4uxgo5kvgoEn7SbuwF9+B1W9Qg1-2jSUm5+iKZdT6-wDEog@mail.gmail.com>
 <20190722104048.463397a0@gandalf.local.home>
Message-ID: <0c2cdd4f-8fe7-6084-9c2d-c2e475e6806e@aol.com>
Date: Mon, 22 Jul 2019 23:33:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722104048.463397a0@gandalf.local.home>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Theodore Ts'o <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Steven,

On 2019/7/22 ????10:40, Steven Rostedt wrote:
>>> and I'm not sure Al could accept __fdget conversion (I just wanted to give a example then...)
>>>
>>> Therefore, I tend to keep silence and just promote EROFS... some better ideas?...
>>>  
>> Writing example conversion patches to demonstrate cleaner code
>> and perhaps reduce LOC seems the best way.
> Yes, I would be more interested in seeing patches that clean up the
> code than just talking about it.
> 

I guess that is related to me, though I didn't plan to promote
a generic tagged pointer implementation in this series...

I try to describe what erofs met and my own implementation,
assume that we have 3 tagged pointers, a, b, c, and one
potential user only (no need to ACCESS_ONCE).

One way is

#define A_MASK		1
#define B_MASK		1
#define C_MASK		3

/* now we have 3 mask there, A, B, C is simple,
   the real name could be long... */

void *a;
void *b;
void *c;		/* and some pointers */

In order to decode the tag, we have to
	((unsigned long)a & A_MASK)

to decode the ptr, we have to
	((unsigned long)a & ~A_MASK)

In order to fold the tagged pointer...
	(void *)((unsigned long)a | tag)

You can see the only meaning of these masks is the bitlength of tags,
but there are many masks (or we have to do open-coded a & 3,
if bitlength is changed, we have to fix them all)...

therefore my approach is

typedef tagptr1_t ta;	/* tagptr type a with 1-bit tag */
typedef tagptr1_t tb;	/* tagptr type b with 1-bit tag */
typedef tagptr2_t tc;	/* tagptr type c with 2-bit tag */

and ta a; tb b; tc c;

the type will represent its bitlength of tags and we can use ta, tb, tc
to avoid masks or open-coded bitlength.

In order to decode the tag, we can
	tagptr_unfold_tags(a)

In order to decode the ptr, we can
	tagptr_unfold_ptr(a)

In order to fold the tagged pointer...
	a = tagptr_fold(ta, ptr, tag)


ACCESS_ONCE stuff is another thing... If my approach seems cleaner,
we could move to include/linux later after EROFS stuffs is done...
Or I could use a better tagptr approach later if any...

Thanks,
Gao XIang



