Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F967515D8
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 03:35:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=ZMHAvknO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1ccs4jqbz3bwY
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 11:35:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=joelfernandes.org header.i=@joelfernandes.org header.a=rsa-sha256 header.s=google header.b=ZMHAvknO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=joelfernandes.org (client-ip=2607:f8b0:4864:20::12a; helo=mail-il1-x12a.google.com; envelope-from=joel@joelfernandes.org; receiver=lists.ozlabs.org)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1ccl3fgnz30MY
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 11:35:33 +1000 (AEST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-345ff33d286so637155ab.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jul 2023 18:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689212130; x=1691804130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qaRxxdr7002yjY9Sb9rO/hl+wvbOVuHe+f71rQQmNs8=;
        b=ZMHAvknOnwQhd7hwVntmR134VIf/xa8j7HZiHjXQ9avrdkys1ATjg4U+6vtSQiEsvf
         GhRM6CAI2OjvDFIornwXuZ348pIlr8Y+MbRK0iFbTN3mULWh7l5Wo6vG2kDv1f1xKnde
         +1VhH8VNCIxNdnXEyC9Uhgl1/ul6MJ6kfbsvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689212130; x=1691804130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaRxxdr7002yjY9Sb9rO/hl+wvbOVuHe+f71rQQmNs8=;
        b=e1CqPzIuCQ1cgOWX9CA8enNKjU6Edw2j4AFuW3B5e+CqEG4i8XKUr6B/kT+l2edOq8
         kaUkXrdgb1RqVyNLIcWcaHg1T1QE3XI/T4fx1uqrC6SKr0LYSfBX1b/7uFNteJZb+6G1
         jMk7VINdnHJAlZGBDuK1SWKJdIGhSOJ5dzhIKTouiE0/Ev+pfNMoZ9zld4gm7XNqmlEs
         ZTR34v6jmVvHVeF0jckPOHn8D0Pvw0Ivulz1sxUqp+foqcAQ75oZK4JasBtEL//WTDm1
         orW/agWw1Eywdtj+6yazg3MOtaMp+DtwYVXERF/YQingj+G+NaLOXHHAri7/itPywDfC
         hN4w==
X-Gm-Message-State: ABy/qLambFUdbOpW8d59Qxz2hC1YxqPGLHYTTD20SHBNqFa52up7bPb6
	wLSt+MLHtr0f3TPfCBjT+AX8rg==
X-Google-Smtp-Source: APBJJlEreT5I7mhbY3CrgO4nPjdHks9kWfD2/wzw3a1D2fzQTpHAli4eHhivkahHLSwBjGrsEf0UHQ==
X-Received: by 2002:a92:de0e:0:b0:347:70a8:1749 with SMTP id x14-20020a92de0e000000b0034770a81749mr71357ilm.24.1689212130076;
        Wed, 12 Jul 2023 18:35:30 -0700 (PDT)
Received: from localhost (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id k1-20020a02a701000000b0042b2df337ccsm1483077jam.76.2023.07.12.18.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 18:35:29 -0700 (PDT)
Date: Thu, 13 Jul 2023 00:32:01 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Sandeep Dhavale <dhavale@google.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <20230713003201.GA469376@google.com>
References: <20230711233816.2187577-1-dhavale@google.com>
 <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
 <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
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
Cc: kernel-team@android.com, "Paul E. McKenney" <paulmck@kernel.org>, Will Shiu <Will.Shiu@mediatek.com>, linux-erofs@lists.ozlabs.org, Boqun Feng <boqun.feng@gmail.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Zqiang <qiang.zhang1211@gmail.com>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Frederic Weisbecker <frederic@kernel.org>, linux-arm-kernel@lists.infradead.org, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jul 12, 2023 at 02:20:56PM -0700, Sandeep Dhavale wrote:
[..]
> > As such this patch looks correct to me, one thing I noticed is that
> > you can check rcu_is_watching() like the lockdep-enabled code does.
> > That will tell you also if a reader-section is possible because in
> > extended-quiescent-states, RCU readers should be non-existent or
> > that's a bug.
> >
> Please correct me if I am wrong, reading from the comment in
> kernel/rcu/update.c rcu_read_lock_held_common()
> ..
>   * The reason for this is that RCU ignores CPUs that are
>  * in such a section, considering these as in extended quiescent state,
>  * so such a CPU is effectively never in an RCU read-side critical section
>  * regardless of what RCU primitives it invokes.
> 
> It seems rcu will treat this as lock not held rather than a fact that
> lock is not held. Is my understanding correct?

If RCU treats it as a lock not held, that is a fact for RCU ;-). Maybe you
mean it is not a fact for erofs?

> The reason I chose not to consult rcu_is_watching() in this version
> is because check "sleeping function called from invalid context"
> will still get triggered (please see kernel/sched/core.c __might_resched())
> as it does not consult rcu_is_watching() instead looks at
> rcu_preempt_depth() which will be non-zero if rcu_read_lock()
> was called (only when CONFIG_PREEMPT_RCU is enabled).

I am assuming you mean you would grab the mutex accidentally when in an RCU
reader, and might_sleep() presumably in the mutex internal code will scream?

I would expect in the erofs code that rcu_is_watching() should always return
true, so it should not effect the decision of whether to block or not. I am
suggesting add the check for rcu_is_watching() into the *held() functions for
completeness.

// will be if (!true) when RCU is actively watching the CPU for readers.
bool rcu_read_lock_any_held() {
	if (!rcu_is_watching())
		return false;
	// do the rest..
}

> > Could you also verify that this patch does not cause bloating of the
> > kernel if lockdep is disabled?
> >
> Sure, I will do the comparison and send the details.

Thanks! This is indeed an interesting usecase of grabbing mutex / blocking in
the reader.

thanks,

 - Joel

